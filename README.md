# Twofishes

[![Build Status](https://img.shields.io/travis/masone/twofishes-ruby.svg?style=flat)](https://travis-ci.org/masone/twofishes-ruby)
[![Code Climate](https://img.shields.io/codeclimate/github/masone/twofishes-ruby.svg?style=flat)](https://codeclimate.com/github/masone/twofishes-ruby)
[![Dependency Status](https://img.shields.io/gemnasium/masone/twofishes-ruby.svg?style=flat)](https://gemnasium.com/masone/twofishes-ruby)
[![Gem Version](https://img.shields.io/gem/v/twofishes.svg?style=flat)](https://rubygems.org/gems/twofishes)

A client/wrapper for foursquare's sparse geocoding / reverse geocoding server Twofishes (https://github.com/foursquare/twofishes).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twofishes'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install twofishes
```

## Configuration

```ruby
Twofishes.configure do |config|
  config.host = '127.0.0.1' # server address
  config.port = 8080 # thrift port
  config.timeout = 3 # timeout in seconds
  config.retries = 2 # how many times to retry a request
end
```

Timeouts are enforced per-try, so if you have a timeout of n and do m retries, the total time it could take is n*m.

## Usage

Use the following methods to geocode / reverse geocode.

```ruby
Twofishes::Client.geocode('Ljubljana')
Twofishes::Client.geocode('Zurich', includes: [ResponseIncludes::PARENTS])
Twofishes::Client.reverse_geocode([0, 0])
```

If you want `.geocode` to return more fields look at `ResponseIncludes` module and pass constants in as an array like in the Zurich example above.

## Compatibility

Ruby 2+

## Generating thrift files

```sh
$ thrift --gen rb -o /path/to/lib /path/to/twofishes-master/interface/src/main/thrift/geocoder.thrift
```

Then rename `gen-rb` folder to `thrift` folder and remove `require` statements from files.

## Contributing

1. Fork it ( http://github.com/masone/twofishes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run tests (`rake test`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
