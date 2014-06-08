require 'httparty'

module Twofishes
  class Client
    # @see https://github.com/foursquare/twofishes/blob/master/docs/twofishes_requests.md

    include HTTParty
    base_uri Twofishes.configuration.base_url
    # debug_output $stderr # httparty debugging

    # Geocodes a given string.
    #
    # @param [String] query
    # @return [Twofishes::Result]
    #
    # @example
    #     Twofishes::Client.geocode('Zurich, Switzerland')
    #
    def self.geocode(location)
      call_api(query: location)
    end

    # Reverse geocodes lat/lng.
    #
    # @param [Float] lat
    # @param [Float] lng
    # @return [Twofishes::Result]
    #
    # @example
    #     Twofishes::Client.reverse_geocode(47.3787733, 8.5273363)
    #
    def self.reverse_geocode(lat, lng)
      call_api(ll: [lat, lng].join(','))
    end

    def self.call_api(params)
      self.new.call_api(params)
    end

    def call_api(params)
      handle_response do
        get('/', query: params)
      end
    end

    private

    def handle_response
      Result.new(yield)
    end

  end
end