$:.push('lib/gen-rb')
require 'pry'
require 'thrift'
require 'geocoder'
port = 8080
timeout = 5
transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', port, timeout))
protocol = Thrift::BinaryProtocol.new(transport)
client = Geocoder::Client.new(protocol)
transport.open
location = GeocodeRequest.new(query: 'Ljubljana')
p client.geocode(location)
transport.close()
