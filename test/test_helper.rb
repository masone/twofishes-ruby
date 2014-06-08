require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'twofishes'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
require 'fakeweb'

FakeWeb.allow_net_connect = false