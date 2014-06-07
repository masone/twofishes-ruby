require 'test_helper'

describe Twofishes::Client do

  describe "geocode" do

    it "should call the api" do
      Twofishes::Client.any_instance.expects(:get).returns({})
      Twofishes::Client.geocode('zurich')
    end

  end

  describe "reverse_geocode" do

    it "should call the api" do
      Twofishes::Client.any_instance.expects(:get).returns({})
      Twofishes::Client.reverse_geocode(0,0)
    end

  end

end