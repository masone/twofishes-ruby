module Twofishes
  class Configuration
    # @see https://github.com/thoughtbot/clearance/blob/master/lib/clearance/configuration.rb

    attr_accessor :host, :port, :timeout, :retries, :connect_timeout

    def initialize
      @host = '127.0.0.1'
      @port = 8080
      @timeout = 3
      @retries = 2
      @connect_timeout = 0.5
    end

    def address
      "#{host}:#{port}"
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
