# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twofishes/version'

Gem::Specification.new do |spec|
  spec.name          = 'twofishes'
  spec.version       = Twofishes::VERSION
  spec.license       = 'MIT'
  spec.authors       = ['Christian Felder', 'Miha Rekar', 'Bartek Bułat', 'Sebastian Delmont']
  spec.email         = ['ema@rh-productions.ch']
  spec.summary       = "Client for foursquare's Twofishes API, a sparse reverse geocoder."
  spec.description   = "Client for foursquare's Twofishes API, a sparse reverse geocoder."
  spec.homepage      = 'https://github.com/masone/twofishes-ruby'

  spec.files         = Dir.glob('lib/**/*.rb')
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0'

  spec.add_dependency 'activesupport'
  spec.add_dependency 'thrift_client'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'pry'
end
