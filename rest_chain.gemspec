# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rest_chain/version'

Gem::Specification.new do |spec|
  spec.name          = "rest_chain"
  spec.version       = RestChain::VERSION
  spec.authors       = ["Peter Wood"]
  spec.email         = ["peter.wood@longboat.com"]
  spec.summary       = %q{A library that abstracts the use of a REST interface.}
  spec.description   = %q{REST chain is a library that abstracts the path elements of making a REST API call to appear as method calls in Ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "webmock", "~> 1.24"

  spec.add_dependency "rest-client", "~> 1.8"
end
