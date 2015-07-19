require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'twofishes'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'mocha/mini_test'

module MiniTest
  class Test
    def mock_thrift_client
      thrift_client = mock
      Twofishes::Client.expects(:thrift_client).returns(thrift_client)
      thrift_client
    end

    def mock_geocode(response)
      mock_thrift_client.expects(:geocode).returns(response)
    end

    def mock_reverse_geocode(response)
      mock_thrift_client.expects(:reverseGeocode).returns(response)
    end
  end
end
