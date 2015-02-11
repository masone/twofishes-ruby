module Twofishes
  class Result
    extend Forwardable

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

    def_delegator :@data, :what
    def_delegator :@data, :where
    def_delegator :@data, :feature
    def_delegator :feature, :name
    def_delegator :feature, :display_name
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

    def parents
      @data.parents.to_a.map { |parent| Twofishes::Result.new(parent) }
    end
  end
end
