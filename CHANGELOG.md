# Changelog

## [v1.0.1] - Unreleased
- Breaking: Oktakit now requires Ruby 3.3 or later.
- Security: resource helpers now validate and percent-encode every ID as a single URL path segment.
  Previously an ID containing `/`, `?`, `#`, `%`, or `;` could change which Okta endpoint or resource was
  called (for example, `get_user("00uX/factors")` requested `/users/00uX/factors`), and an ID of `..`
  could resolve to a different resource. IDs that are empty, `.` or `..`, or that contain `/` or `;`, now
  raise `ArgumentError` instead of sending a request. Okta decodes `%2F` back into `/` and ignores
  everything after `;`, so these characters cannot be made safe by encoding.
- Security: `list_applications_assigned_to_user` sends `filter` and `expand` as query parameters and
  JSON-escapes the user ID inside the filter. These two values now override any caller-supplied `filter`
  or `expand`.
- Security: the `organization` option must be a single Okta subdomain label (letters, digits and inner
  hyphens). Previously a value such as `"evil.example#"` made the client send every request, including
  the API token, to `evil.example`. Invalid values now raise `ArgumentError`. This check is skipped when
  `api_endpoint` is given, because `api_endpoint` takes precedence.
- Lookups by login send `@` as `%40`, as Okta's API documentation recommends. Logins that contain `/`
  must be fetched by user ID, which matches Okta's documented behavior.
- Request paths no longer double-encode existing percent escapes. A path passed to `get`, `post`, `put`,
  `patch`, `delete`, or `head` containing `%2F` is now sent as `%2F` instead of `%252F`, and encoded
  pagination links are followed unchanged.

## [v1.0.0] - 2023-07-12
- [Upgrade to Faraday 2.x](https://github.com/Shopify/oktakit/pull/68)

## [v0.3.3] - 2022-07-20
- [Loosen sawyer dependency to allow 0.9.1](https://github.com/Shopify/oktakit/pull/61)

## [v0.3.2] - 2022-06-30
- [Fix 'Faraday::Connection#authorization' deprecation warning](https://github.com/Shopify/oktakit/pull/56)

## [v0.3.1] - 2022-01-20
- [Reverts a breaking change that caused errors to be raised for non-2xx responses](https://github.com/Shopify/oktakit/pull/54)

## [v0.3.0] - 2022-01-20
- [Adds support for Ruby 3](https://github.com/Shopify/oktakit/pull/42)
- [Adds support for user reactivation endpoint](https://github.com/Shopify/oktakit/pull/47)
- [Adds support for app user schema operations endpoint](https://github.com/Shopify/oktakit/pull/32)
- [Makes custom error details available](https://github.com/Shopify/oktakit/pull/48)

## [v0.2.1] - 2021-10-14
- Adds support for [Group Rule operations](https://developer.okta.com/docs/reference/api/groups/#group-rule-operations)
