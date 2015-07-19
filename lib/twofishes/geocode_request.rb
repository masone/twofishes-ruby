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
      options = Hash[options.map{|k,v| [k.to_s.camelize(:lower).to_sym,v] } ]

      options[:maxInterpretations] ||= options.delete(:max)
      options[:allowedSources] ||= options.delete(:sources)
      options[:responseIncludes] ||= options.delete(:includes)
      options[:autocompleteBias] ||= options.delete(:bias)

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
