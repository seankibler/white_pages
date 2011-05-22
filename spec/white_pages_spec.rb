require 'spec_helper'

describe WhitePages do
  context "Valid API Key" do
    it "should find a person" do
      WhitePages.find_person(name: 'John Doe').should be_an_instance_of(Hashie::Mash)
    end
    
    it "should find a business" do
      WhitePages.find_business(businessname: 'Target').should be_an_instance_of(Hashie::Mash)
    end
    
    it "should reverse a phone number" do
      WhitePages.reverse_phone(phone: '3236030004').should be_an_instance_of(Hashie::Mash)
    end
    
    it "should reverse an address" do
      WhitePages.reverse_address(street: 'Santa Monica Blvd').should be_an_instance_of(Hashie::Mash)
    end
  end
  
  context "Invalid API Key" do
    it "should raise errors" do
      WhitePages.api_key = 'invalid'
      lambda { WhitePages.find_person(name: 'John Doe') }.should raise_error(WhitePages::WhitePagesError)
    end
  end
end