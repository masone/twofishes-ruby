module Twofishes

  class Configuration

    # @see https://github.com/thoughtbot/clearance/blob/master/lib/clearance/configuration.rb

    attr_accessor :base_url

    def initialize
      @base_url = 'http://localhost:8081'
    end

  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end

  def self.reset_configuration
    @configuration = nil
  end

end