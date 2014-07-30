require 'rash'

module Twofishes

  class Result

    def initialize(hash)
      @data = Hashie::Rash.new(hash)
    end

    def self.from_response(hash)
      if hash['interpretations']
        hash['interpretations'].map { |interpretation| self.new(interpretation) }
      else
        []
      end
    end

    def name
      feature.name
    end

    def display_name
      feature.display_name
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
      @data.parents.map { |parent| Twofishes::Result.new(parent) }
    end

    def method_missing(method_sym, *arguments, &block)
      @data.send(method_sym)
    end

    def respond_to?(method_sym, include_private=false)
      @data.respond_to?(method_sym) ? true : super
    end

  end
end