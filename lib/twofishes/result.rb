module Twofishes
  class Result
    def initialize(hash)
      @data = ResultFields.new(hash)
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

    def method_missing(name, *args, &block)
      @data.send(name)
    end

    def respond_to?(name, include_private = false)
      @data.include?(name) || super
    end
  end
end