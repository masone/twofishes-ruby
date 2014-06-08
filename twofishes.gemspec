# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twofishes/version'

Gem::Specification.new do |spec|
  spec.name          = "twofishes"
  spec.version       = Twofishes::VERSION
  spec.authors       = ["Christian Felder (masone)"]
  spec.email         = ["ema@rh-productions.ch"]
  spec.summary       = "Client for foursquare's Twofishes API, a sparse reverse geocode."
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency "api_smith"


  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "fakeweb"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "yard"

end
