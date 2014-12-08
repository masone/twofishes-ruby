module Twofishes

  class Configuration

    # @see https://github.com/thoughtbot/clearance/blob/master/lib/clearance/configuration.rb

    attr_accessor :base_url, :timeout

    def initialize
      @base_url = 'http://localhost:8081'
      @timeout = 3
    end

  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.reset_configuration
    @configuration = nil
  end

end
