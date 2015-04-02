# Change Log

## 2.0.0 (2015-04-02)

- Now uses thrift instead of REST which is up to [60% faster](https://github.com/masone/twofishes-ruby/pull/4#issuecomment-74030852). [mrfoto, barthez]
                   
### Breaking changes :warning:

- `Twofishes.configure` no longer accepts `base_url`. You now need to provide `host` and `port` separately. Please make sure that you're using the thrift port (8080 by default), not the HTTP port (8081 by default) anymore.
- Thrift does not include all available fields in the response by default. To get them, you can explicitly pass `geocode` an `includes` keyword argument with an array of Array of `ResponseIncludes` constants. There is an example in the README.

## 1.0.1 (2014-12-08)

- Adds timeout option, configurable with `Twofishes.configure`.

## 1.0.0 (2014-07-30)

- Initial stable version.
- Structural improvements, best practices.
