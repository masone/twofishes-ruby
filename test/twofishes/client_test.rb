require 'test_helper'
require 'pry'
module Twofishes
  class Zurich
    def self.geocode(location)
      if location.responseIncludes == [ResponseIncludes::PARENTS]
        response = YAML::load_file('test/fixtures/response_with_parents.yaml')
      else
        response = YAML::load_file('test/fixtures/response.yaml')
      end

      if location.query
        response.interpretations.first.feature.name = location.query
      end

      if location.ll
        response.interpretations.first.feature.geometry.center.lat = location.ll.lat
        response.interpretations.first.feature.geometry.center.lng = location.ll.lng
      end
      response
    end

    def self.reverseGeocode(location)
      if location.responseIncludes == [ResponseIncludes::PARENTS]
        response = YAML::load_file('test/fixtures/response_with_parents.yaml')
      else
        response = YAML::load_file('test/fixtures/response.yaml')
      end

      if location.ll
        response.interpretations.first.feature.geometry.center.lat = location.ll.lat
        response.interpretations.first.feature.geometry.center.lng = location.ll.lng
      end
      response
    end
  end

  describe Client do
    it 'should geocode' do
      Twofishes::Client.expects(:thrift_client).returns(Zurich)
      response = Twofishes::Client.geocode('Zurich').first

      assert response.is_a? Result
      assert_equal "Zurich", response.feature.name
      assert_equal nil, response.parents
    end

    it 'should geocode with parameters' do
      Twofishes::Client.expects(:thrift_client).returns(Zurich)
      response = Twofishes::Client.geocode('Caracas', ll: "40.74,-74", includes: [ResponseIncludes::PARENTS]).first

      assert response.is_a? Result
      assert_equal "Caracas", response.feature.name
      assert_equal 40.74, response.feature.geometry.center.lat
      assert_equal 4, response.parents.size
    end

    it 'should not geocode with unexpected parameters' do
      assert_raises Twofishes::InvalidResponseError do
        response = Twofishes::Client.geocode('Caracas', keywords: 'sushi').first
      end
    end

    it 'should reverse geocode' do
      Twofishes::Client.expects(:thrift_client).returns(Zurich)
      response = Twofishes::Client.reverse_geocode([0, 0]).first

      assert response.is_a? Result
      assert_equal "Zürich", response.feature.name
      assert_equal 0, response.feature.geometry.center.lat
    end

    it 'should reverse geocode with parameters' do
      Twofishes::Client.expects(:thrift_client).returns(Zurich)
      response = Twofishes::Client.reverse_geocode([0, 0], includes: [ResponseIncludes::PARENTS]).first

      assert response.is_a? Result
      assert_equal "Zürich", response.feature.name
      assert_equal 0, response.feature.geometry.center.lat
      assert_equal 4, response.parents.size
    end
  end
end
