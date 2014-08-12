# [Stoplight Admin][1]

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

gem 'stoplight-admin', '~> 0.1.0'
```

Run [Bundler][3] to install the dependencies:

``` sh
$ bundle install
```

Lastly we need to make our (tiny) application. Here's a typical
example using a local Redis data store:

``` rb
# app.rb

require 'sinatra'
require 'sinatra/stoplight_admin'

REDIS_URL = 'redis://localhost:6379'
set :data_store, Stoplight::DataStore::Redis.new(url: REDIS_URL)

```

## Usage

``` sh
$ bundle exec ruby app.rb
```

## Credits

Stoplight is brought to you by [@camdez][4] and [@tfausak][5] from
[@OrgSync][6].

[1]: https://github.com/orgsync/stoplight-admin
[2]: https://github.com/orgsync/stoplight
[3]: http://bundler.io
[4]: https://github.com/camdez
[5]: https://github.com/tfausak
[6]: https://github.com/OrgSync
