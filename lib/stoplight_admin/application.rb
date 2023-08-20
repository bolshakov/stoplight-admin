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
        lights, stats = dependencies.home_action.()

        erb :index, locals: stats.merge(lights: lights)
      end

      app.get '/stats' do
        lights, stats = dependencies.stats_action.()

        json({stats: stats, lights: lights.map(&:as_json)})
      end

      app.post '/lock' do
        dependencies.lock_action.(params)

        redirect to('/')
      end

      app.post '/unlock' do
        dependencies.unlock_action.(params)

        redirect to('/')
      end

      app.post '/green' do
        dependencies.green_action.(params)

        redirect to('/')
      end

      app.post '/red' do
        dependencies.red_action.(params)

        redirect to('/')
      end

      app.post '/green_all' do
        dependencies.green_all_action.()

        redirect to('/')
      end
    end
  end
end

Zeitwerk::Loader.eager_load_all

register StoplightAdmin::Application