require 'forwardable'
require 'active_support/core_ext/string/inflections'

module Twofishes
  class Result
    extend Forwardable

    def initialize(interpretation)
      @interpretation = interpretation
    end

    def self.from_response(response)
      response.interpretations.map { |interpretation|
        new(interpretation)
      }
    end

    def_delegator :@interpretation, :what
    def_delegator :@interpretation, :where
    def_delegator :@interpretation, :feature
    def_delegator :feature, :cc, :country_code

    def lat
      feature.geometry.center.lat
    end

    def lng
      feature.geometry.center.lng
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
