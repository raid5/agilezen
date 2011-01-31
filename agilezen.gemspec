require File.expand_path("../lib/agilezen/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'agilezen'
  s.version     = AgileZen::VERSION
  s.authors     = ['Adam McDonald']
  s.email       = ['mcdonald.adam@gmail.com']
  s.homepage    = 'http://github.com/raid5/agilezen'
  s.summary     = 'Ruby wrapper for the AgileZen API'
  s.description = s.summary
  
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rake', '~> 0.8'
  s.add_development_dependency 'rspec', '~> 2.4'
  s.add_development_dependency 'cucumber', '~> 0.10.0'
  s.add_development_dependency 'fakeweb', '~> 1.3.0'
  
  s.add_runtime_dependency 'faraday', '~> 0.5.4'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.3.0'
  s.add_runtime_dependency 'multi_json', '~> 0.0.5'
  s.add_runtime_dependency 'hashie', '~> 0.4.0'

  s.required_rubygems_version = '>= 1.3.6'
  s.platform                  = Gem::Platform::RUBY
  s.rubyforge_project         = "agilezen"
  s.require_path              = 'lib'
  s.files                     = `git ls-files`.split("\n")
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
end