require 'test_helper'

module Twofishes
  describe Client do
    let(:geocode_response_with_parents) { YAML.load_file('test/fixtures/response_with_parents.yaml') }
    let(:geocode_response) { YAML.load_file('test/fixtures/response.yaml') }

    describe 'geocode' do
      it 'should return a valid result' do
        mock_geocode(geocode_response)
        response = Twofishes::Client.geocode('Zurich').first

        assert response.is_a? Result
      end

      it 'should return fields' do
        mock_geocode(geocode_response)
        response = Twofishes::Client.geocode('Zurich').first

        assert_equal 'Zürich', response.feature.name
        assert_equal 47.36667, response.feature.geometry.center.lat
        assert_equal nil, response.parents
      end

      it 'should return parents when requested' do
        mock_geocode(geocode_response_with_parents)
        response = Twofishes::Client.geocode('Zurich', includes: [ResponseIncludes::PARENTS]).first

        assert_equal 4, response.parents.size
      end

      it 'should accept additional parameters' do
        mock_geocode(geocode_response)
        response = Twofishes::Client.geocode('Zurich', lang: 'fr').first

        assert response.is_a? Result
      end

      it 'should not geocode with unexpected parameters' do
        assert_raises Twofishes::InvalidResponseError do
          Twofishes::Client.geocode('Zurich', keywords: 'sushi').first
        end
      end
    end

    describe 'reverse geocode' do
      it 'should return a valid result' do
        mock_reverse_geocode(geocode_response)
        response = Twofishes::Client.reverse_geocode('Zurich').first

        assert response.is_a? Result
      end

      it 'should return fields' do
        mock_reverse_geocode(geocode_response)
        response = Twofishes::Client.reverse_geocode('Zurich').first

        assert_equal 'Zürich', response.feature.name
        assert_equal 47.36667, response.feature.geometry.center.lat
        assert_equal nil, response.parents
      end

      it 'should return parents when requested' do
        mock_reverse_geocode(geocode_response_with_parents)
        response = Twofishes::Client.reverse_geocode('Zurich', includes: [ResponseIncludes::PARENTS]).first

        assert_equal 4, response.parents.size
      end

      it 'should accept additional parameters' do
        mock_reverse_geocode(geocode_response)
        response = Twofishes::Client.reverse_geocode('Zurich', lang: 'fr').first

        assert response.is_a? Result
      end

      it 'should not geocode with unexpected parameters' do
        assert_raises Twofishes::InvalidResponseError do
          Twofishes::Client.reverse_geocode('Zurich', keywords: 'sushi').first
        end
      end
    end
  end
end
