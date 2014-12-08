require 'test_helper'

describe Twofishes::Configuration do

  after do
    Twofishes.reset_configuration
  end

  let(:configuration){ Twofishes.configuration }

  it "should return configuration" do
    assert configuration.is_a? Twofishes::Configuration
  end

  it "should return default base_url" do
    assert_equal 'http://localhost:8081', configuration.base_url
  end

  it "should return default timeout" do
    assert_equal 3, configuration.timeout
  end

  it "should reset configuration" do
    Twofishes.configure do |config|
      config.base_url = 'http://demo.twofishes.net'
    end
    Twofishes.reset_configuration

    assert_equal 'http://localhost:8081', configuration.base_url
  end

  it "should configure base_url" do
    Twofishes.configure do |config|
      config.base_url = 'http://demo.twofishes.net'
    end

    assert_equal 'http://demo.twofishes.net', configuration.base_url
    Twofishes.reset_configuration
  end

end
