require 'hashie/mash'

module Twofishes

  class Result

    def initialize(hash)
      @data = Hashie::Mash.new(hash)
    end

    def name
      feature.name
    end

    def display_name
      feature.displayName
    end

    def country_code
      feature.cc
    end

    def lat
      feature.geometry.center.lat
    end

    def lng
      feature.geometry.center.lng
    end

    def coordinates
      [lat, lng]
    end

    def parents
      @data.parents.map{|parent| Twofishes::Result.new(parent) }
    end

    def method_missing(method_sym, *arguments, &block)
      @data.send(method_sym)
    end

  end
end