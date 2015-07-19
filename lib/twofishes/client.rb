module Twofishes
  class Client
    # @see https://github.com/foursquare/twofishes/blob/master/docs/twofishes_requests.md

    # Geocodes a given string.
    #
    # @param [String] location
    # @param [Array] list of additional ResponseIncludes constants
    # @return [Twofishes::Result]
    #
    # @example
    #   Twofishes::Client.geocode('Zurich, Switzerland')
    #

    def self.geocode(location, options = {})
      handle_response do
        options[:query] = location
        request = Twofishes::GeocodeRequest.new(options)
        thrift_client.geocode(request)
      end
    end

    # Reverse geocodes lat/lng.
    #
    # @param [Array] latitude, longitude pair
    # @return [Twofishes::Result]
    # @example
    #   Twofishes::Client.reverse_geocode([47.3787733, 8.5273363])
    #
    def self.reverse_geocode(coordinates, options = {})
      handle_response do
        options[:ll] = coordinates
        request = Twofishes::GeocodeRequest.new(options)
        thrift_client.reverseGeocode(request)
      end
    end

    def self.thrift_client
      ThriftClient.new(
        Geocoder::Client,
        Twofishes.configuration.address,
        retries: Twofishes.configuration.retries,
        timeout: Twofishes.configuration.timeout,
        connect_timeout: Twofishes.configuration.connect_timeout
      )
    end

    private

    def self.handle_response
      Result.from_response(yield)
    rescue => e
      raise Twofishes::InvalidResponseError, e.message
    end
  end
end
