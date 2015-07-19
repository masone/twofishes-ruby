require 'test_helper'

describe Twofishes::GeocodeRequest do
  it 'should accept a query argument' do
    request = Twofishes::GeocodeRequest.new(query: "Caracas")
    assert_equal "Caracas", request.query
  end

  it 'should accept a lang argument' do
    request = Twofishes::GeocodeRequest.new(lang: "EN")
    assert_equal "EN", request.lang
  end

  it 'should accept a max argument' do
    request = Twofishes::GeocodeRequest.new(max: 5)
    assert_equal 5, request.maxInterpretations
  end

  it 'should accept a max_interpretations argument' do
    request = Twofishes::GeocodeRequest.new(max_interpretations: 5)
    assert_equal 5, request.maxInterpretations
  end

  it 'should accept an includes argument' do
    request = Twofishes::GeocodeRequest.new(includes: [ResponseIncludes::PARENTS])
    assert_equal [ResponseIncludes::PARENTS], request.responseIncludes
  end

  it 'should accept a response_includes argument' do
    request = Twofishes::GeocodeRequest.new(response_includes: [ResponseIncludes::PARENTS])
    assert_equal [ResponseIncludes::PARENTS], request.responseIncludes
  end

  it 'should accept an ll argument' do
    request = Twofishes::GeocodeRequest.new(ll: GeocodePoint.new(lat: 40.74, lng: -74.0))
    assert_equal 40.74, request.ll.lat
    assert_equal -74.0, request.ll.lng
  end

  it 'should accept an ll argument that is a string' do
    request = Twofishes::GeocodeRequest.new(ll: "40.74,-74")
    assert_equal 40.74, request.ll.lat
    assert_equal -74.0, request.ll.lng
  end

  it 'should accept an ll argument that is an array' do
    request = Twofishes::GeocodeRequest.new(ll: [40.74, -74.0])
    assert_equal 40.74, request.ll.lat
    assert_equal -74.0, request.ll.lng
  end

  it 'should accept an ll argument that is a hash' do
    request = Twofishes::GeocodeRequest.new(ll: {lng: -74.0, lat: 40.74})
    assert_equal 40.74, request.ll.lat
    assert_equal -74.0, request.ll.lng
  end

  it 'should accept an ll argument that is a hash with "lon"' do
    request = Twofishes::GeocodeRequest.new(ll: {lon: -74.0, lat: 40.74})
    assert_equal 40.74, request.ll.lat
    assert_equal -74.0, request.ll.lng
  end

  it 'should accept a bounds argument' do
    request = Twofishes::GeocodeRequest.new(bounds: GeocodeBoundingBox.new(ne: GeocodePoint.new(lat: 40.74, lng: -74.0), sw: GeocodePoint.new(lat: 40.70, lng: -73.9)))
    assert_equal 40.74, request.bounds.ne.lat
    assert_equal -74.0, request.bounds.ne.lng
    assert_equal 40.70, request.bounds.sw.lat
    assert_equal -73.9, request.bounds.sw.lng
  end

  it 'should accept a bounds argument that is a string' do
    request = Twofishes::GeocodeRequest.new(bounds: "40.74,-74.0,40.70,-73.9")
    assert_equal 40.74, request.bounds.ne.lat
    assert_equal -74.0, request.bounds.ne.lng
    assert_equal 40.70, request.bounds.sw.lat
    assert_equal -73.9, request.bounds.sw.lng
  end

  it 'should accept a bounds argument that is an array' do
    request = Twofishes::GeocodeRequest.new(bounds: [40.74, -74.0, 40.70, -73.9])
    assert_equal 40.74, request.bounds.ne.lat
    assert_equal -74.0, request.bounds.ne.lng
    assert_equal 40.70, request.bounds.sw.lat
    assert_equal -73.9, request.bounds.sw.lng
  end

end