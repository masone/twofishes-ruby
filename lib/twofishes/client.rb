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

    def self.geocode(location, includes: [], slug: nil, max: nil, ll: nil, radius: nil, bounds: nil, strict: nil, cc: nil, lang: nil, autocomplete: nil, bias: nil)
      handle_response do
        case ll
        when String
          lat, lng = ll.split /\s*,\s*/
          ll = GeocodePoint.new(lat: lat.to_f, lng: lng.to_f)
        when Array
          ll = GeocodePoint.new(lat: ll[0].to_f, lng: ll[1].to_f)
        when Hash
          ll = GeocodePoint.new(lat: (ll[:lat] || ll['lat']).to_f, lng: (ll[:lng] || ll['lng'] || ll[:lon] || ll['lon']).to_f)
        end

        case radius
        when String
          radius = radius.to_f
        end

        case bounds
        when String
          ne_lat, ne_lng, sw_lat, sw_lng = bounds.split /\s*,\s*/
          ne = GeocodePoint.new(lat: ne_lat.to_f, lng: ne_lng.to_f)
          sw = GeocodePoint.new(lat: sw_lat.to_f, lng: sw_lng.to_f)
          bounds = GeocodeBoundingBox.new(ne: ne, sw: sw)
        when Array
          ne = GeocodePoint.new(lat: bounds[0].to_f, lng: bounds[1].to_f)
          sw = GeocodePoint.new(lat: bounds[2].to_f, lng: bounds[3].to_f)
          bounds = GeocodeBoundingBox.new(ne: ne, sw: sw)
        when Hash
          ne = GeocodePoint.new(lat: (bounds[:ne_lat] || bounds['ne_lat']).to_f, lng: (bounds[:ne_lng] || bounds['ne_lng'] || bounds[:ne_lon] || bounds['ne_lon']).to_f)
          sw = GeocodePoint.new(lat: (bounds[:sw_lat] || bounds['sw_lat']).to_f, lng: (bounds[:sw_lng] || bounds['sw_lng'] || bounds[:sw_lon] || bounds['sw_lon']).to_f)
          bounds = GeocodeBoundingBox.new(ne: ne, sw: sw)
        end

        request = GeocodeRequest.new(
          query: location, 
          slug: slug, 
          maxInterpretations: max, responseIncludes: includes, 
          ll: ll, radius: radius, bounds: bounds, strict: strict, 
          cc: cc, lang: lang, 
          autocomplete: autocomplete, autocompleteBias: bias
        )
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
    def self.reverse_geocode(coordinates, includes: [])
      handle_response do
        point = GeocodePoint.new(lat: coordinates[0], lng: coordinates[1])
        request = GeocodeRequest.new(ll: point, responseIncludes: includes)
        thrift_client.reverseGeocode(request)
      end
    end

    def self.thrift_client
      ThriftClient.new(
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
