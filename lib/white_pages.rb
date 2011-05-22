require 'hashie'
require 'httparty'

module WhitePages
  VERSION = "0.0.1"

  class WhitePagesError < StandardError; end

  autoload :Client, 'white_pages/client'

  class << self
    attr_accessor :api_key
  end
  
  def self.find_person(options)
    Client.new(self.api_key).find_person(options)
  end
  
  def self.find_business(options)
    Client.new(self.api_key).find_business(options)
  end
  
  def self.reverse_address(options)
    Client.new(self.api_key).reverse_address(options)
  end
  
  def self.reverse_phone(options)
    Client.new(self.api_key).reverse_phone(options)
  end
end