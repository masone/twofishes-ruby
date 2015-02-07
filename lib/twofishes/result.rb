module Twofishes
  class Result
    def initialize(hash)
      @data = hash
    end

    def self.from_response(hash)
      if hash['interpretations']
        hash['interpretations'].map { |interpretation| self.new(interpretation) }
      else
        []
      end
    end

    def what
      @data['what']
    end

    def where
      @data['where']
    end

    def country_code
      feature['cc']
    end

    def lat
      feature['geometry']['center']['lat']
    end

    def lng
      feature['geometry']['center']['lng']
    end

    def coordinates
      [lat, lng]
    end

    def feature
      @data['feature']
    end

    def parents
      @data['parents'].map { |parent| Twofishes::Result.new(parent) }
    end

    def method_missing(method_sym, *arguments, &block)
      return super unless respond_to?(method_sym)
      feature.send(:[], derubyfy_key(method_sym))
    end

    def respond_to?(method_sym, include_private = false)
      feature.include?(derubyfy_key(method_sym)) ? true : super
    end

    private

    def derubyfy_key(key)
      key.to_s.gsub(/_[a-z]/) { |m| m[1].upcase }
    end
  end
end