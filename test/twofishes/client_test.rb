require 'test_helper'

describe Twofishes::Client do
  it "should geocode" do
    Twofishes::Client.geocode('zurich')
  end

  it "should reverse geocode" do
    Twofishes::Client.reverse_geocode([0, 0])
  end
end
