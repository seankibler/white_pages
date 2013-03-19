require 'white_pages/client'

module WhitePages
  VERSION = "0.0.1"

  class WhitePagesError < StandardError; end

  class << self
    attr_accessor :api_key
  end
  
  def self.find_person(options)
    Client.new.find_person(options)
  end
  
  def self.find_business(options)
    Client.new.find_business(options)
  end
  
  def self.reverse_address(options)
    Client.new.reverse_address(options)
  end
  
  def self.reverse_phone(options)
    Client.new.reverse_phone(options)
  end
end
