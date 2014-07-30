require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'twofishes'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'mocha/mini_test'
require 'fakeweb'

FakeWeb.allow_net_connect = /^https:\/\/codeclimate\.com/

class MiniTest::Spec

  before do
    FakeWeb.clean_registry
  end

end