# [Stoplight Admin][1]

[![Gem version][7]][8]

A simple administration interface for [stoplight][2].  Monitor the
status, failures, and invocations of your stoplights.  Change
stoplight colors, or lock them in either red or green state.

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

require 'redis'
require 'sinatra'
require 'sinatra/stoplight_admin'

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
require 'sinatra/stoplight_admin'

class StoplightAdmin < Sinatra::Base
  register Sinatra::StoplightAdmin

  redis = Redis.new # Uses REDIS_URL environment variable.
  data_store = Stoplight::DataStore::Redis.new(redis)
  set :data_store, data_store
end

Rails.application.routes.draw do
  mount StoplightAdmin => '/stoplights'
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
