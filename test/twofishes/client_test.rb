require 'test_helper'

module Twofishes
  class Zurich
    def self.geocode(location)
      YAML::load_file('test/fixtures/response.yaml')
    end

    def self.reverseGeocode(location)
      YAML::load_file('test/fixtures/response.yaml')
    end
  end

  class ZurichWithParents
    def self.geocode(location)
      YAML::load_file('test/fixtures/response_with_parents.yaml')
    end
  end

  describe Client do
    it 'should geocode' do
      Twofishes::Client.expects(:thrift_client).returns(Zurich)
      assert Twofishes::Client.geocode('Zurich').first.is_a? Result
    end

    it 'should accept includes keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', includes: [ResponseIncludes::PARENTS]).first
      assert result.parents
    end

    it 'should reverse geocode' do
      Twofishes::Client.expects(:thrift_client).returns(Zurich)
      Twofishes::Client.reverse_geocode([0, 0]).first.is_a? Result
    end
  end
end
