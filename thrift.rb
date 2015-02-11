$:.push('lib/gen-rb')
require 'pry'
require 'thrift_client'
require 'geocoder'

client = ThriftClient.new(Geocoder::Client, '127.0.0.1:8080', retries: 2)
location = GeocodeRequest.new(query: 'Ljubljana')
client.geocode(location)
