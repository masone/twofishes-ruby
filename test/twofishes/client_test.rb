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

    it 'should accept max keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', max: 5).first
      assert result.parents
    end

    it 'should accept ll keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', ll: "47,8").first
      assert result.displayName

      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', ll: [47,8]).first
      assert result.displayName

      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', ll: {:lng => 8, lat: 47}).first
      assert result.displayName

      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', ll: {"lng" => 8, lat: 47}).first
      assert result.displayName
    end

    it 'should accept radius keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', radius: 5000).first
      assert result.parents
    end

    it 'should accept bounds keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', bounds: "47,8,45,7").first
      assert result.displayName

      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', bounds: [47, 8, 45, 7]).first
      assert result.displayName

      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', bounds: {:nw_lng => 8, nw_lat: 47, se_lat: 45, se_lon: 7}).first
      assert result.displayName

      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', bounds: {"nw_lng" => 8, nw_lat: 47, "se_lon" => 7, se_lat: 45}).first
      assert result.displayName
    end

    it 'should accept strict keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', strict: true).first
      assert result.parents
    end

    it 'should accept cc keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', cc: "CH").first
      assert result.parents
    end

    it 'should accept lang keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', lang: "IT").first
      assert result.parents
    end

    it 'should accept autocomplete keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('Zurich', autocomplete: true).first
      assert result.parents
    end

    it 'should accept slug keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('', slug: "1234567890").first
      assert result.parents
    end

    it 'should accept bias keyword argument' do
      Twofishes::Client.expects(:thrift_client).returns(ZurichWithParents)
      result = Twofishes::Client.geocode('', bias: AutocompleteBias::LOCAL).first
      assert result.parents
    end

    it 'should reverse geocode' do
      Twofishes::Client.expects(:thrift_client).returns(Zurich)
      Twofishes::Client.reverse_geocode([0, 0]).first.is_a? Result
    end
  end
end
