module Twofishes
  class Configuration
    # @see https://github.com/thoughtbot/clearance/blob/master/lib/clearance/configuration.rb

    attr_accessor :address, :retries

    def initialize
      @address = '127.0.0.1:8080'
      @retries = 2
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
