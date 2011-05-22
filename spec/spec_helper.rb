require 'rubygems'
require 'bundler/setup'

require 'white_pages'

RSpec.configure do |config|
  config.mock_with :rspec
end

# Be sure to pass wp_api_key=XXX or change the API key here
WhitePages.api_key = ENV['wp_api_key'] || '0123456789abcdef'