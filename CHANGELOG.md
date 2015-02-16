# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [2.0.0-pre][unreleased]

- Now uses thrift instead of REST. #4
- Up to [60% faster](https://github.com/masone/twofishes-ruby/pull/4#issuecomment-74030852).
- `Twofishes.configure` now accepts `host` and `port` respectively. Be aware you need to provide thrift port (8080 by default), not http server port (8081 by default).
- The response no longer includes `parents` by default. You can easily get them by passing `[ResponseIncludes::PARENTS]` as the `:includes` keyword argument to `geocode`. Look at the README for an example.

## [1.0.1] - 2014-12-08

- Adds timeout option, configurable with `Twofishes.configure`

## [1.0.0] - 2014-07-30

- Initial stable version.
- Structural improvements, best practices.

## [1.0.0.pre] - 2014-06-30

- Development version, subject to changes.
