require 'test_helper'

describe Twofishes::InvalidResponseError do
  it 'should raise InvalidResponseError' do
    assert_raises Twofishes::InvalidResponseError do
      fail Twofishes::InvalidResponseError, 'test'
    end
  end

  it 'should be a StandardError' do
    Twofishes::InvalidResponseError.new.is_a?(StandardError)
  end
end
