# coding: utf-8

lib = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH.push(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name = 'stoplight-admin'
  gem.version = '0.4.0'
  gem.summary = 'A simple administration interface for Stoplight.'
  gem.description = gem.summary
  gem.homepage = 'https://github.com/bolshakov/stoplight-admin'
  gem.license = 'MIT'

  {
    'Cameron Desautels' => 'camdez@gmail.com',
    'Taylor Fausak' => 'taylor@fausak.me'
  }.tap do |hash|
    gem.authors = hash.keys
    gem.email = hash.values
  end

  gem.files = %w(LICENSE.md README.md) +
    Dir.glob(File.join('lib', '**', '*.rb')) +
    Dir.glob(File.join('lib', '**', '*.haml'))

  gem.required_ruby_version = '>= 2.5.0'

  {
    'haml' => '5.0',
    'sinatra-contrib' => '3.0.0'
  }.each do |name, version|
    gem.add_dependency(name, "~> #{version}")
  end

  gem.add_dependency 'redis', '>= 3.2'
  gem.add_dependency 'stoplight', '~> 3.0.0'

  {
    'bundler' => '2.4',
    'pry-byebug' => '3.10.0',
    'rake' => '13.0',
    'rspec' => '3.12.0'
  }.each do |name, version|
    gem.add_development_dependency(name, "~> #{version}")
  end
end
