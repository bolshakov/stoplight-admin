lib = File.expand_path("lib", File.dirname(__FILE__))
$LOAD_PATH.push(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name = "stoplight-admin"
  gem.version = "0.4.0"
  gem.summary = "A simple administration interface for Stoplight."
  gem.description = gem.summary
  gem.homepage = "https://github.com/bolshakov/stoplight-admin"
  gem.license = "MIT"

  {
    "Cameron Desautels" => "camdez@gmail.com",
    "Taylor Fausak" => "taylor@fausak.me"
  }.tap do |hash|
    gem.authors = hash.keys
    gem.email = hash.values
  end

  gem.files = %w[LICENSE.md README.md] +
    Dir.glob(File.join("lib", "**", "*.rb")) +
    Dir.glob(File.join("lib", "**", "*.erb"))

  gem.required_ruby_version = ">= 3.2"

  gem.executables = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }

  gem.add_dependency "redis", "~> 5.4"
  gem.add_dependency "zeitwerk"
  gem.add_dependency "sinatra", "~> 4.0"
  gem.add_dependency "sinatra-contrib", "~> 4.0"
  gem.add_dependency "stoplight", ">= 4.1"
end
