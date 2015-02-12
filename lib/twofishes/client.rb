module Twofishes
  class Client
    # @see https://github.com/foursquare/twofishes/blob/master/docs/twofishes_requests.md

    # Geocodes a given string.
    #
    # @param [String] location
    # @return [Twofishes::Result]
    #
    # @example
    #   Twofishes::Client.geocode('Zurich, Switzerland')
    #
    def self.geocode(location)
      handle_response do
        thrift_client.geocode(GeocodeRequest.new(query: location))
      end
    end

    # Reverse geocodes lat/lng.
    #
    # @overload reverse_geocode(lat, lng)
    #   @param [Float] latitude
    #   @param [Float] longitude
    #   @return [Twofishes::Result]
    # @overload reverse_geocode([lat, lng])
    #   @param [Array] latitude, longitude pair
    #   @return [Twofishes::Result]
    # @example
    #   Twofishes::Client.reverse_geocode(47.3787733, 8.5273363)
    #   Twofishes::Client.reverse_geocode([47.3787733, 8.5273363])
    #
    def self.reverse_geocode(*coordinates)
      handle_response do
        coords = coordinates.flatten
        point = GeocodePoint.new(lat: coords[0], lng: coords[1])
        thrift_client.reverseGeocode(GeocodeRequest.new(ll: point))
      end
    end

    def self.thrift_client
      @@thrift_client ||= ThriftClient.new(Geocoder::Client, Twofishes.configuration.address, retries: Twofishes.configuration.retries)
    end

    private

    def self.handle_response
      Result.from_response(yield)
    rescue => e
      raise Twofishes::InvalidResponseError, e.message
    end
  end
end
