require 'active_support/core_ext/string/inflections'

module Underscored
  def self.included(base)
    base::FIELDS.map do |_, v|
      define_method(v[:name].underscore) { send(v[:name]) }
    end
  end
end

class GeocodeInterpretation
  include Underscored
end

class GeocodeFeature
  include Underscored
end
