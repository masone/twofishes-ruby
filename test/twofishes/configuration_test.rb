require 'test_helper'

describe Twofishes::Configuration do
  after do
    Twofishes.reset_configuration
  end

  let(:configuration){ Twofishes.configuration }

  it "should return configuration" do
    assert configuration.is_a? Twofishes::Configuration
  end

  it "should return default address" do
    assert_equal '127.0.0.1:8080', configuration.address
  end

  it "should return default retries" do
    assert_equal 2, configuration.retries
  end

  it "should reset configuration" do
    Twofishes.configure do |config|
      config.address = '127.0.0.1:9090'
    end
    Twofishes.reset_configuration

    assert_equal '127.0.0.1:8080', configuration.address
  end

  it "should configure address" do
    Twofishes.configure do |config|
      config.address = '127.0.0.1:9090'
    end

    assert_equal '127.0.0.1:9090', configuration.address
    Twofishes.reset_configuration
  end
end
