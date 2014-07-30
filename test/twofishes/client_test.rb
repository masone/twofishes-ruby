require 'test_helper'

describe Twofishes::Client do

  it "should geocode" do
    FakeWeb.register_uri(:get, 'http://localhost:8081/?query=zurich', :status => 200, :body => '{}')
    Twofishes::Client.geocode('zurich')
  end

  it "should reverse geocode" do
    FakeWeb.register_uri(:get, 'http://localhost:8081/?ll=0%2C0', :status => 200, :body => '{}')
    Twofishes::Client.reverse_geocode([0, 0])
  end

  it "should call api" do
    FakeWeb.register_uri(:get, 'http://localhost:8081/?query=zurich', :status => 200, :body => '{}')
    Twofishes::Client.call_api({query: 'zurich'})
  end

  it "should raise an error" do
    FakeWeb.register_uri(:get, 'http://localhost:8081', :status => 500, :body => 'java.lang.NumberFormatException: For input string: ""')
    assert_raises Twofishes::InvalidResponseError do
      Twofishes::Client.call_api({})
    end
  end

end