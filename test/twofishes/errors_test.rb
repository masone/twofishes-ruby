require 'test_helper'

describe Twofishes::Errors do

  it "should raise Errors::InvalidResponse" do
    assert_raises Twofishes::Errors::InvalidResponse do
      raise Twofishes::Errors::InvalidResponse, 'test'
    end
  end

  it "should be a StandardError" do
    Twofishes::Errors::InvalidResponse.new.is_a?(StandardError)
  end

end