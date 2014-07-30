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
      config.base_url = 'http://mytwofishes.com:8081'
    end

## Usage

Use the following methods to geocode / reverse geocode.

    Twofishes::Client.reverse_geocode([0, 0])
    Twofishes::Client.geocode('zurich')

If you want more control over the params, you can also use the ```call_api``` method directly.

    Twofishes::Client.call_api({query: 'zurich'})

## Compatibility

Ruby ~> 2.0 and ~> 2.1

## Contributing

1. Fork it ( http://github.com/masone/twofishes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run tests (`rake test`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request