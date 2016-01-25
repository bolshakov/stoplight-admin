# Example stoplight-admin app that reads the redis URL from env var and listens on port 80.

require 'redis'
require 'sinatra'
require 'sinatra/stoplight_admin'

redis = Redis.new(url: ENV["STOPLIGHT_REDIS_URL"])
set :port, ENV["STOPLIGHT_PORT"] 
set :data_store, Stoplight::DataStore::Redis.new(redis)
