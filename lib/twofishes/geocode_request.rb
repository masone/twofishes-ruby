module Twofishes
  class GeocodeRequest < ::GeocodeRequest
    def initialize(options = {})
      options = substitute_aliases(options)

      options[:ll] = prepare_ll(options[:ll])
      options[:bounds] = prepare_bounds(options[:bounds])

      super(options)
    end

    def prepare_ll(ll)
      case ll
      when String
        lat, lng = ll.split(/\s*,\s*/)
        new_point(lat, lng)
      when Array
        new_point(ll[0], ll[1])
      when Hash
        new_point(ll[:lat], ll[:lng])
      else
        ll
      end
    end

    def prepare_bounds(bounds)
      case bounds
      when String
        ne_lat, ne_lng, sw_lat, sw_lng = bounds.split(/\s*,\s*/)
        new_bounding_box(ne_lat, ne_lng, sw_lat, sw_lng)
      when Array
        new_bounding_box(bounds[0], bounds[1], bounds[2], bounds[3])
      when Hash
        new_bounding_box(bounds[:ne_lat], bounds[:ne_lng], bounds[:sw_lat], bounds[:sw_lng])
      else
        bounds
      end
    end

    def substitute_aliases(options)
      options = options.dup

      options[:maxInterpretations] ||= options.delete(:max_interpretations) || options.delete(:max)
      options[:allowedSources] ||= options.delete(:allowed_sources) || options.delete(:sources)
      options[:responseIncludes] ||= options.delete(:response_includes) || options.delete(:includes)
      options[:woeHint] ||= options.delete(:woe_hint)
      options[:woeRestrict] ||= options.delete(:woe_restrict)
      options[:autocompleteBias] ||= options.delete(:autocomplete_bias) || options.delete(:bias)

      if options[:ll].kind_of? Hash
        options[:ll][:lng] = options[:ll][:lon] if options[:ll][:lon]
      end

      if options[:bounds].kind_of? Hash
        options[:bounds][:ne_lng] = options[:bounds][:ne_lon] if options[:bounds] and options[:bounds][:ne_lon]
        options[:bounds][:sw_lng] = options[:bounds][:sw_lon] if options[:bounds] and options[:bounds][:sw_lon]
      end

      options
    end

    private

    def new_bounding_box(ne_lat, ne_lng, sw_lat, sw_lng)
      ne = GeocodePoint.new(lat: ne_lat.to_f, lng: ne_lng.to_f)
      sw = GeocodePoint.new(lat: sw_lat.to_f, lng: sw_lng.to_f)
      GeocodeBoundingBox.new(ne: ne, sw: sw)
    end

    def new_point(lat, lng)
      GeocodePoint.new(lat: lat.to_f, lng: lng.to_f)
    end
  end
end
