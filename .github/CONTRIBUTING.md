# Oktakit Contributing Guide

Thank you for showing interest in contributing! Before you start contributing,
plesae make sure that you take a look at the following guidelines and adhere to
them:

- [Code of
  Conduct](https://github.com/hectron/oktakit/blob/main/.github/CODE_OF_CONDUCT.md)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Development Setup](#development-setup)

## Pull Request Guidelines

1. [Fork this repository](https://github.com/hectron/oktakit/fork)
1. Create your feature branch (`git checkout -b my-new-feature`)
1. Commit your changes (`git commit -am 'Add some feature'`)
1. Push to the branch (`git push origin my-new-feature`)
1. Create a new Pull Request

- If you are adding a new feature:
  - Add test coverage
  - Provide an explanation of why this feature is needed, why you took the
    approach that you decided on, and some screenshots of it in action.

- If you are fixing a bug:
  - If you are resolving a special issue, add `(fix #xxxx[,#xxxx])` (`#xxxx` is
    the issue id) in your PR title for a better release log, e.g. `fix users
    update endpoint (fix #2112)`
  - Provide a detailed description of the bug in the PR, and steps to recreate
    the bug on a fresh clone.
  - Add appropriate test coverage

- It's OK to have multiple small commits -- they will be automatically squahed
  before it is merged in

- Make sure you've run the test suite

## Development Setup

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Testing

To run the test suite, run:

```bash
$ bundle exec rspec
```

Testing is fairly straightforward, with the exception of the org URL.
To anonymize the VCR data, first setup a real token and endpoint for Okta, such as `myokta.okta.com`

- In `spec_helper.rb`, set the org to `my-okta` (or whatever your organization is).
- Set the `OKTA_TEST_TOKEN` environment variable (this should be real). Don't worry, it is automatically removed.
- Before committing, change `my-okta` to `okta-test` in `spec_helper.rb` and any VCR Cassettes.

The [API Test Client](https://developer.okta.com/docs/api/getting_started/api_test_client) provided by Okta is also really helpful.


