# [Stoplight Admin][1]

[![Gem version][7]][8]

A simple administration interface for [stoplight][2].  Monitor the
status, failures, and invocations of your stoplights.  Change
stoplight colors, or lock them in either red or green state.

The stoplight-admin version 0.4 and above is only compatible with Stoplight 4.1. If you have Stoplight version 
below 4.0, use [stoplight-admin 0.3.6]. 

## Configuration

This project is packaged as a Ruby gem so that you can easily embed it
in your own code containing the configuration details for your
[stoplight][2] data store.

First you'll need a `Gemfile`:

``` rb
source 'https://rubygems.org'

gem 'stoplight-admin'
```

Run [Bundler][3] to install the dependencies:

``` sh
$ bundle install
```

Lastly we need to make our (tiny) application. Here's a typical
example using a local Redis data store:

``` rb
# app.rb

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem "puma"
  gem "rackup"
  gem 'redis'
  gem 'stoplight-admin'
  gem 'webrick'
end

require 'redis'
require 'sinatra'
require 'stoplight_admin/application'

redis = Redis.new(url: 'redis://localhost:6379')
set :data_store, Stoplight::DataStore::Redis.new(redis)
```

## Reverse Proxying

If you run Stoplight Admin behind a reverse proxy (nginx, for
instance) at a URL other than root, you'll need to add the following
lines to your `app.rb` file:

``` rb
use Rack::Config do |env|
  env['SCRIPT_NAME'] = '/your/prefix/here'
end
```

## Usage

``` sh
$ bundle exec ruby app.rb
```

## Rails

It is possible to mount Stoplight Admin inside Rails.
Add something like this to your `config/routes.rb`:

``` rb
require 'redis'
require 'stoplight_admin/application'

class StoplightAdminApp < Sinatra::Base
  register StoplightAdmin::Application

  redis = Redis.new # Uses REDIS_URL environment variable.
  data_store = Stoplight::DataStore::Redis.new(redis)
  set :data_store, data_store
end

Rails.application.routes.draw do
  mount StoplightAdminApp => '/stoplights'
end
```

## Credits

Stoplight is brought to you by [@camdez][4] and [@tfausak][5] from
[@OrgSync][6].

[1]: https://github.com/bolshakov/stoplight-admin
[2]: https://github.com/bolshakov/stoplight
[3]: http://bundler.io
[4]: https://github.com/camdez
[5]: https://github.com/tfausak
[6]: https://github.com/OrgSync
[7]: https://badge.fury.io/rb/stoplight-admin.svg
[8]: https://rubygems.org/gems/stoplight-admin
[stoplight-admin 0.3.6]: https://github.com/bolshakov/stoplight-admin/releases/tag/v0.3.6
