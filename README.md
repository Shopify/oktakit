# oktakit

Ruby toolkit for the [Okta API](http://developer.okta.com/docs/api/getting_started/design_principles.html).

[![Build Status](https://secure.travis-ci.org/Shopify/oktakit.png)](http://travis-ci.org/Shopify/oktakit)
[![Gem Version](https://badge.fury.io/rb/oktakit.png)](http://badge.fury.io/rb/oktakit)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oktakit'
```

And then execute:

    $ bundle

## Usage

`Oktakit` follow the same patterns as [`Octokit`](https://github.com/octokit/octokit.rb), if you are familiar with it you should feel right at home.

```ruby
client = Oktakit.new(token: 't0k3n', organization: 'my-great-org')
agents = client.rels[:agents].get.data
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/shopify/oktakit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
