require 'active_support/core_ext/string/inflections'

module Camelized
  def self.included(base)
    base::FIELDS.map { |_, v|
      define_method(v[:name].underscore) { send(v[:name]) }
    }
  end
end

class GeocodeInterpretation
  include Camelized
end

class GeocodeFeature
  include Camelized
end
