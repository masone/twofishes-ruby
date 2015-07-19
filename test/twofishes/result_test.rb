require 'test_helper'

describe Twofishes::Result do
  let(:response) { YAML.load_file('test/fixtures/response.yaml') }
  let(:results) { Twofishes::Result.from_response(response) }
  let(:result) { results.first }

  describe 'results' do
    it 'should return an Array' do
      assert results.is_a? Array
    end

    it 'should return an Array containing Result objects' do
      assert results.first.is_a? Twofishes::Result
    end
  end

  describe 'result' do
    it 'should return fields from response' do
      assert_equal 'pizza', result.what
      assert_equal 'zürich', result.where
    end

    it 'should return fields with nested data' do
      geometry = response.interpretations.first.feature.geometry
      assert_equal geometry, result.feature.geometry
    end

    it 'should return country_code' do
      assert_equal 'CH', result.country_code
    end

    it 'should return name' do
      assert_equal 'Zürich', result.name
    end

    it 'should return display_name' do
      assert_equal 'Zürich, Switzerland', result.display_name
    end

    it 'should return lat' do
      assert_equal 47.36667, result.lat
    end

    it 'should return lng' do
      assert_equal 8.55, result.lng
    end

    it 'should return coordinates' do
      assert_equal [47.36667, 8.55], result.coordinates
    end

    it 'should rubyfy keys' do
      assert_equal 'Zürich, Switzerland', result.display_name
    end

    it 'should raise NoMethodError for missing key' do
      assert_raises(NoMethodError) do
        result.foobar
      end
    end
  end

  it 'should respond to existing key' do
    assert result.respond_to?(:feature)
  end

  it 'should respond to missing key' do
    assert_equal false, result.respond_to?(:foobar)
  end
end
