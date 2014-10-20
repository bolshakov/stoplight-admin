# coding: utf-8

require 'haml'
require 'sinatra/base'
require 'stoplight'

module Sinatra
  module StoplightAdmin
    module Helpers
      COLORS = [
        GREEN = Stoplight::DataStore::COLOR_GREEN,
        YELLOW = Stoplight::DataStore::COLOR_YELLOW,
        RED = Stoplight::DataStore::COLOR_RED
      ].freeze

      def data_store
        return @data_store if defined?(@data_store)
        @data_store = Stoplight.data_store = settings.data_store
      end

      def lights
        data_store
          .names
          .map { |name| light_info(name) }
          .sort_by { |light| light_sort_key(light) }
      end

      def light_info(light)
        color = Stoplight.data_store.get_color(light)
        attempts = color == GREEN ? 0  : data_store.get_attempts(light)
        failures = color == GREEN ? [] : data_store.get_failures(light)

        {
          name: light,
          color: color,
          failures: failures,
          attempts: attempts,
          locked: locked?(light)
        }
      end

      def light_sort_key(light)
        [COLORS.index(light[:color]),
         light[:attempts] * -1,
         light[:name]]
      end

      def locked?(light_name)
        [Stoplight::DataStore::STATE_LOCKED_GREEN,
         Stoplight::DataStore::STATE_LOCKED_RED]
          .include?(data_store.get_state(light_name))
      end

      def stat_params(ls)
        total_count = ls.size
        success_count = ls.count { |l| l[:color] == GREEN }
        failure_count = total_count - success_count

        if total_count > 0
          failure_percentage = (100.0 * failure_count / total_count).ceil
          success_percentage = 100 - failure_percentage
        else
          failure_percentage = success_percentage = 0
        end

        {
          success_count: success_count,
          failure_count: failure_count,
          success_percentage: success_percentage,
          failure_percentage: failure_percentage
        }
      end

      def lock(light)
        new_state =
          if Stoplight.data_store.green?(light)
            Stoplight::DataStore::STATE_LOCKED_GREEN
          else
            Stoplight::DataStore::STATE_LOCKED_RED
          end

        data_store.set_state(light, new_state)
      end

      def unlock(light)
        data_store.set_state(light, Stoplight::DataStore::STATE_UNLOCKED)
      end

      def green(light)
        if data_store.get_state(light) == Stoplight::DataStore::STATE_LOCKED_RED
          new_state = Stoplight::DataStore::STATE_LOCKED_GREEN
          data_store.set_state(light, new_state)
        end

        data_store.clear_attempts(light)
        data_store.clear_failures(light)
      end

      def red(light)
        data_store.set_state(light, Stoplight::DataStore::STATE_LOCKED_RED)
      end

      def purge
        data_store.clear_stale
      end

      def with_lights
        [*params[:names]]
          .map  { |l| URI.unescape(l) }
          .each { |l| yield(l) }
      end
    end

    def self.registered(app)
      app.helpers StoplightAdmin::Helpers

      app.set :data_store, nil
      app.set :views, File.join(File.dirname(__FILE__), 'views')

      app.get '/' do
        ls    = lights
        stats = stat_params(ls)

        haml :index, locals: stats.merge(lights: ls)
      end

      app.post '/lock' do
        with_lights { |l| lock(l) }
        redirect to('/')
      end

      app.post '/unlock' do
        with_lights { |l| unlock(l) }
        redirect to('/')
      end

      app.post '/green' do
        with_lights { |l| green(l) }
        redirect to('/')
      end

      app.post '/red' do
        with_lights { |l| red(l) }
        redirect to('/')
      end

      app.post '/green_all' do
        data_store.names
          .reject { |l| Stoplight.data_store.green?(l) }
          .each { |l| green(l) }
        redirect to('/')
      end

      app.post '/purge' do
        purge
        redirect to('/')
      end
    end
  end

  register StoplightAdmin
end
