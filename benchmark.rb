$:.push('lib')
require 'thrift_client'
require 'httparty'
require 'twofishes/geocoder_types'
require 'twofishes/geocoder'

module Twofishes
  class ClientThrift
    def self.geocode(location)
      client.geocode(GeocodeRequest.new(query: location))
    rescue => e
      p e
    end

    def self.client
      @@client ||= ThriftClient.new(Geocoder::Client, '127.0.0.1:8080', retries: 2)
    end
  end

  class ClientHttp
    include HTTParty
    def self.geocode(location)
      get('http://localhost:8081', query: {query: location}, timeout: 10)
    rescue => e
      p e
    end
  end
end

require 'benchmark/ips'

Benchmark.ips do |x|
  x.config(:time => 20, :warmup => 5)

  ljubljana = 'ljubljana'

  x.report('thrift') do |times|
    Twofishes::ClientThrift.geocode(ljubljana)
  end

  x.report('http') do |times|
    Twofishes::ClientHttp.geocode(ljubljana)
  end

  x.compare!
end
