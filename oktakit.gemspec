lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oktakit/version'

Gem::Specification.new do |spec|
  spec.name          = 'oktakit'
  spec.version       = Oktakit::VERSION
  spec.authors       = ['Graeme Johnson', 'Julian Nadeau']
  spec.email         = ['graeme.johnson@shopify.com', 'julian@shopify.com']

  spec.summary       = 'Ruby toolkit for working with the Okta API'
  spec.homepage      = 'https://github.com/Shopify/oktakit'
  spec.license       = 'MIT'

  spec.files         = %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6'

  spec.add_dependency('sawyer', '~> 0.8.1')
  spec.add_development_dependency('bundler')
end
