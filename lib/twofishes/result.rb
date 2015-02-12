require 'forwardable'
require 'active_support/core_ext/string/inflections'

module Twofishes
  class Result
    extend Forwardable
    def_delegators :@interpretation, :what, :where, :feature

    def self.from_response(response)
      response.interpretations.map { |interpretation|
        new(interpretation)
      }
    end

    def initialize(interpretation)
      @interpretation = interpretation
    end

    def country_code
      cc
    end

    def lat
      geometry.center.lat
    end

    def lng
      geometry.center.lng
    end

    def coordinates
      [lat, lng]
    end

    def method_missing(name, *args, &block)
      camelized = name.to_s.camelize(:lower)
      feature.respond_to?(camelized) ? feature.send(camelized) : super
    end

    def respond_to_missing?(name, include_private = false)
      feature.respond_to?(name.to_s.camelize(:lower)) || super
    end
  end
end
