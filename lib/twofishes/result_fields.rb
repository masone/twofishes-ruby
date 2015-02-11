require 'active_support/core_ext/string/inflections'

module Twofishes
  class ResultFields
    def initialize(hash)
      @hash = hash
    end

    def to_h
      @hash.dup
    end

    alias_method :to_hash, :to_h

    def [](key)
      wrap_value @hash[key.to_s.camelize(:lower)]
    end

    def include?(key)
      @hash.include? key.to_s.camelize(:lower)
    end

    def method_missing(name, *args, &block)
      include?(name) ? self[name] : super
    end

    def respond_to?(name, include_private = false)
      include?(name) || super
    end

    private

    def wrap_value(value)
      value.is_a?(Hash) ? self.class.new(value) : value
    end
  end
end
