# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/json'
require 'stoplight_admin'

module StoplightAdmin
  module Application

    def self.registered(app)
      app.helpers Application::Helpers

      app.set :data_store, nil
      app.set :views, File.join(File.dirname(__FILE__), 'views')

      app.get '/' do
        action = StoplightAdmin::Actions::Home.new(
          lights_repository: lights_repository,
          lights_stats: StoplightAdmin::LightsStats
        )
        lights, stats = action.call

        erb :index, locals: stats.merge(lights: lights)
      end

      app.get '/stats' do
        action = StoplightAdmin::Actions::Stats.new(
          lights_repository: lights_repository,
          lights_stats: StoplightAdmin::LightsStats
        )
        lights, stats = action.call

        json({stats: stats, lights: lights.map(&:as_json)})
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
                  .reject { |l| Stoplight::Light.new(l) {}.color == Stoplight::Color::GREEN }
                  .each { |l| green(l) }
        redirect to('/')
      end
    end
  end
end

Zeitwerk::Loader.eager_load_all

register StoplightAdmin::Application
