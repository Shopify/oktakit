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

```sh
bundle
```

## Usage

`Oktakit` follows similar patterns as found in [`Octokit`](https://github.com/octokit/octokit.rb). So if you are familiar with Octokit, then you should feel right at home.

```ruby
client = Oktakit.new(token: 't0k3n', organization: 'my-great-org')
response, http_status = client.list_users
```

To work with the Okta sandbox (`<organization>.oktapreview.com`), set the `api_endpoint`:

```ruby
client = Oktakit.new(token: 't0k3n', api_endpoint: 'https://my-great-org.oktapreview.com/api/v1')
```

### Pagination

Pass the `paginate` flag as options for any `get` action for Oktakit to autopaginate the response for you.

```ruby
client = Oktakit.new(token: 't0k3n', organization: 'my-great-org')
response, http_status = client.list_users(paginate: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Releasing

Releases use [RubyGems Trusted Publishing](https://guides.rubygems.org/trusted-publishing/)
through [the release workflow](.github/workflows/release.yml). No RubyGems API key or
repository secret is needed.

### One-time setup

Before pushing a release tag:

1. A repository administrator must create the `release` GitHub environment, configure
   required reviewers, and restrict deployments to tags matching `v*`.
2. An owner of the `oktakit` gem on RubyGems.org must add a GitHub trusted publisher with:

   | Setting | Value |
   | --- | --- |
   | Repository owner | `Shopify` |
   | Repository name | `oktakit` |
   | Workflow filename | `release.yml` |
   | Environment | `release` |

   Leave the optional workflow-repository fields blank; this workflow lives in the gem's repository.

The environment name must match on GitHub and RubyGems.org. Merely referencing an
environment in the workflow does not configure its approval or tag restrictions.

### Publish a version

1. Update `lib/oktakit/version.rb`, `Gemfile.lock`, and `CHANGELOG.md` in a PR.
2. Merge the PR and confirm CI passes. The tagged commit must include the release workflow.
3. From a clean, up-to-date checkout of `main`, tag the version and push the tag:

   ```sh
   git tag -a v1.0.1 -m "Release 1.0.1"
   git push origin refs/tags/v1.0.1
   ```

   Substitute the version being released. The workflow rejects tags that do not match
   `Oktakit::VERSION` or point outside `main`.
4. Approve the `release` environment deployment and wait for the workflow to succeed.
5. Verify the version on [RubyGems.org](https://rubygems.org/gems/oktakit), then create
   a GitHub release from the existing tag.

If authentication fails, check the trusted publisher settings and re-run the failed
workflow after correcting them. Check RubyGems.org first: do not retry publishing a
version that already succeeded or move an existing release tag.

## Testing

Testing is fairly straightforward, with the exception of the org URL.
To anonymize the VCR data, first setup a real token and endpoint for Okta, such as `myokta.okta.com`

- In `spec_helper.rb`, set the org to `my-okta` (or whatever your organization is).
- Set the `OKTA_TEST_TOKEN` environment variable (this should be real). Don't worry, it is automatically removed.
- Before committing, change `my-okta` to `okta-test` in `spec_helper.rb` and any VCR Cassettes.

The [API Test Client](https://developer.okta.com/docs/api/getting_started/api_test_client) provided by Okta is also really helpful.

## Contributing

1. Fork it ( <https://github.com/shopify/oktakit/fork> )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Contributor License Agreement

 New contributors will be required to sign [Shopify's Contributor License Agreement (CLA)](https://cla.shopify.com/).
 There are two versions of the CLA: one for individuals and one for organizations.
