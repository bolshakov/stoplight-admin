# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = 'stoplight-admin'
  spec.version       = '0.2.6'
  spec.authors       = ['Cameron Desautels', 'Taylor Fausak']
  spec.email         = %w(camdez@gmail.com taylor@fausak.me)
  spec.summary       = %q{A simple administration interface for the stoplight gem.}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/orgsync/stoplight-admin'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'haml', '~> 4.0.5'
  spec.add_dependency 'redis', '~> 3.1.0'
  spec.add_dependency 'sinatra', '~> 1.4.5'
  spec.add_dependency 'stoplight', '~> 0.4.1'
end
