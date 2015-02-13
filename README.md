Twofishes [![Build Status](https://travis-ci.org/masone/twofishes-ruby.svg?branch=master)](https://travis-ci.org/masone/twofishes-ruby) [![Code Climate](https://codeclimate.com/repos/539493ee69568044cb013dde/badges/385f7d64548a83e99792/gpa.png)](https://codeclimate.com/repos/539493ee69568044cb013dde/feed) [![Dependency Status](https://gemnasium.com/masone/twofishes-ruby.svg)](https://gemnasium.com/masone/twofishes-ruby)
========

A client/wrapper for foursquare's sparse geocoding / reverse geocoding server Twofishes (https://github.com/foursquare/twofishes).

## Installation

Add this line to your application's Gemfile:

    gem 'twofishes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twofishes

## Configuration

    Twofishes.configure do |config|
      config.host = '127.0.0.1'
      config.port = 8080
      config.timeout = 3
      config.retries = 2
    end

## Usage

Use the following methods to geocode / reverse geocode.

    Twofishes::Client.geocode('ljubljana')
    Twofishes::Client.geocode('zurich', [ResponseIncludes::PARENTS])
    Twofishes::Client.reverse_geocode([0, 0])

If you want `.geocode` to return more fields look at `ResponseIncludes` module and pass constants in as an array like in the example above.

## Compatibility

Ruby 2+

## Generating thrift files

```
❯ thrift --gen rb -o /path/to/lib /path/to/twofishes-master/interface/src/main/thrift/geocoder.thrift
```
Then move out of `gen-rb` folder to `twofishes` folder and remove `require`s.

## Contributing

1. Fork it ( http://github.com/masone/twofishes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run tests (`rake test`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
