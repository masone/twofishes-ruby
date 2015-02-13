require 'test_helper'

module Twofishes
  describe Client do
    let(:response) { YAML::load_file('test/fixtures/zurich.yaml') }

    it 'should geocode' do
      Twofishes::Client.thrift_client.stubs(:geocode).returns(response)
      assert Twofishes::Client.geocode('Zurich').first.is_a? Result
    end

    it 'should reverse geocode' do
      Twofishes::Client.thrift_client.stubs(:reverseGeocode).returns(response)
      Twofishes::Client.reverse_geocode([0, 0]).first.is_a? Result
    end
  end
end
