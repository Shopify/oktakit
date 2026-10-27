lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oktakit/version'

Gem::Specification.new do |spec|
  spec.name          = 'oktakit'
  spec.version       = Oktakit::VERSION
  spec.authors       = ['Shopify']
  spec.email         = ['ruby@shopify.com']

  spec.summary       = 'Ruby toolkit for working with the Okta API'
  spec.homepage      = 'https://github.com/Shopify/oktakit'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files         = %x(git ls-files -z).split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.3'

  spec.add_dependency('sawyer', '>= 0.8.1', '< 0.10')
  spec.add_dependency('faraday', '>= 2.0.1', '< 3')
end
