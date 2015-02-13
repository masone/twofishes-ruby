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
    def self.geocode(location, response_includes = [])
      handle_response do
        thrift_client.geocode(GeocodeRequest.new(query: location, responseIncludes: response_includes))
      end
    end

    # Reverse geocodes lat/lng.
    #
    # @param [Array] latitude, longitude pair
    # @return [Twofishes::Result]
    # @example
    #   Twofishes::Client.reverse_geocode([47.3787733, 8.5273363])
    #
    def self.reverse_geocode(coords)
      handle_response do
        point = GeocodePoint.new(lat: coords[0], lng: coords[1])
        thrift_client.reverseGeocode(GeocodeRequest.new(ll: point))
      end
    end

    def self.thrift_client
      @thrift_client ||= ThriftClient.new(
        Geocoder::Client,
        Twofishes.configuration.address,
        retries: Twofishes.configuration.retries,
        timeout: Twofishes.configuration.timeout
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
