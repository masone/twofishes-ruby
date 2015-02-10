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
      wrap_value @hash[key]
    end

    def include?(key)
      @hash.include? key.to_s.camelize(:lower)
    end

    def method_missing(name, *args, &block)
      key = name.to_s.camelize(:lower)
      self[key] if @hash.include?(key)
    end

    def respond_to?(name, include_private = false)
      @hash.include?(name.to_s.camelize(:lower)) || super
    end

    private

    def wrap_value(value)
      return self.class.new(value) if value.is_a?(Hash)
      value
    end
  end
end