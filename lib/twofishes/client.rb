module Twofishes
  class Client
    # @see https://github.com/foursquare/twofishes/blob/master/docs/twofishes_requests.md

    # Geocodes a given string.
    #
    # @param [String] query
    # @return [Twofishes::Result]
    #
    # @example
    #     Twofishes::Client.geocode('Zurich, Switzerland')
    #
    def self.geocode(location)
      handle_response do
        client.geocode(GeocodeRequest.new(query: location))
      end
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
    def self.reverse_geocode(*coordinates)
      handle_response do
        coords = coordinates.flatten
        point = GeocodePoint.new(lat: coords[0], lng: coords[1])
        client.reverseGeocode(GeocodeRequest.new(ll: point))
      end
    end

    private

    def self.client
      @@client ||= ThriftClient.new(Geocoder::Client, Twofishes.configuration.address, retries: Twofishes.configuration.retries)
    end

    def self.handle_response
      Result.from_response(yield)
    rescue => e
      raise Twofishes::InvalidResponseError, e.message
    end
  end
end
