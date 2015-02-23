# coding: utf-8

lib = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH.push(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name = 'stoplight-admin'
  gem.version = '0.2.9'
  gem.summary = 'A simple administration interface for Stoplight.'
  gem.description = gem.summary
  gem.homepage = 'https://github.com/orgsync/stoplight-admin'
  gem.license = 'MIT'

  gem.required_ruby_version = '>= 1.9.3'

  {
    'Cameron Desautels' => 'camdez@gmail.com',
    'Taylor Fausak' => 'taylor@fausak.me'
  }.tap do |hash|
    gem.authors = hash.keys
    gem.email = hash.values
  end

  gem.files = %w(CONTRIBUTING.md LICENSE.md README.md) +
    Dir.glob(File.join('lib', '**', '*.rb'))

  {
    'haml' => '~> 4.0',
    'redis' => '~> 3.1',
    'sinatra' => '~> 1.4',
    'stoplight' => '~> 0.5'
  }.each do |name, version|
    gem.add_dependency name, version
  end

  {
    'bundler' => '~> 1.8',
    'rake' => '~> 10.4'
  }.each do |name, version|
    gem.add_development_dependency name, version
  end
end
