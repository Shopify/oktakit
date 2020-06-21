# oktakit

Ruby toolkit for the [Okta API](http://developer.okta.com/docs/api/getting_started/design_principles.html).

[![Build Status](https://secure.travis-ci.org/Shopify/oktakit.png)](http://travis-ci.org/Shopify/oktakit)
[![Gem Version](https://badge.fury.io/rb/oktakit.png)](http://badge.fury.io/rb/oktakit)
[![Contributor
Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code_of_conduct.md)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oktakit', git: 'https://github.com/hectron/oktakit'
```

And then execute:

```bash
$ bundle
```

## Usage

`Oktakit` follows similar patterns as found in [`Octokit`](https://github.com/octokit/octokit.rb). So if you are familiar with Oktakit, then you should feel right at home.

To work with the Okta sandbox environments (e.g. `<organization>.oktapreview.com`), set the `api_endpoint`:

```ruby
client = Oktakit.new(token: 't0k3n', api_endpoint: 'https://my-great-org.oktapreview.com/api/v1')
```

For regular okta environments, you can use `organization`:

```ruby
client = Oktakit.new(token: 't0k3n', organization: 'my-great-org')
```

The return values of each method are tuples, containing the body of the
response, and the status code.

```ruby
response, http_status = client.list_users
```

To analyze the last response, you can call `.last_response`:

```ruby
response = client.last_response
headers = response.headers
```

#### Pagination

Pass the `paginate` flag as options for any `get` action for Oktakit to autopaginate the response for you.

```ruby
client = Oktakit.new(token: 't0k3n', organization: 'my-great-org')
response, http_status = client.list_users(paginate: true)
```

## Contributing

Thanks for showing interest in contributing! Please read the [Contributing
Guide](https://github.com/hectron/oktakit/blob/main/.github/CONTRIBUTING.md) before
submitting a pull request.

