require 'hashie'

module WhitePages
  class Client
    include HTTParty
    base_uri 'http://api.whitepages.com'

    # API Version
    def version
      '1.0'
    end

    # Find a person
    #
    # http://developer.whitepages.com/docs/read/Methods/find_person
    #
    # * <tt>:firstname</tt>
    # * <tt>:lastname</tt> - Required unless :name is provided
    # * <tt>:name</tt> - Full name. Required unless :lastname is provided
    # * <tt>:house</tt> - House number
    # * <tt>:street</tt> - Street name, including any directional prefix or suffix
    # * <tt>:city</tt>
    # * <tt>:state</tt> - USPS two-character abbreviation
    # * <tt>:zip</tt> - Will accept 5 digit ZIP Code or 9 digit ZIP+4
    # * <tt>:areacode</tt>
    # * <tt>:metro</tt> - Expand search to metro area
    # 
    # == Example
    #
    #  WhitePages.api_key = API_KEY
    #  WhitePages.find_person(name: 'John Doe', state: 'CA')
    #
    def find_person(options = {})
      fetch(:find_person, options)
    end

    # Find a business
    #
    # http://developer.whitepages.com/docs/read/Methods/find_business
    #
    # * <tt>:businessname</tt> - Required unless :category is provided
    # * <tt>:category</tt> - Required unless :businessname is provided
    # * <tt>:house</tt> - House number
    # * <tt>:street</tt> - Street name, including any directional prefix or suffix
    # * <tt>:city</tt>
    # * <tt>:state</tt> - USPS two-character abbreviation
    # * <tt>:zip</tt> - Will accept 5 digit ZIP Code or 9 digit ZIP+4
    # * <tt>:areacode</tt>
    # * <tt>:metro</tt> - Expand search to metro area
    # 
    # == Example
    #
    #  WhitePages.api_key = API_KEY
    #  WhitePages.find_business(businessname: 'Target', city: 'Los Angeles', state: 'CA')
    #
    def find_business(options = {})
      fetch(:find_business, options)
    end

    # Reverse lookup of a phone number
    #
    # http://developer.whitepages.com/docs/read/Methods/reverse_phone
    #
    # * <tt>:phone</tt> - 7 or 10 digits
    # * <tt>:state</tt> - USPS two-character abbreviation. Required if :phone is 7 digits 
    # 
    # == Example
    #
    #  WhitePages.api_key = API_KEY
    #  WhitePages.reverse_phone(phone: '3334445555')
    #
    def reverse_phone(options = {})
      fetch(:reverse_phone, options)
    end

    # Reverse lookup of an address
    #
    # http://developer.whitepages.com/docs/read/Methods/reverse_address
    #
    # * <tt>:house</tt> - House number
    # * <tt>:apt</tt> - Apartment number
    # * <tt>:street</tt> - Street name, including any directional prefix or suffix. Required
    # * <tt>:city</tt>
    # * <tt>:state</tt> - USPS two-character abbreviation
    # * <tt>:zip</tt> - Will accept 5 digit ZIP Code or 9 digit ZIP+4
    # * <tt>:areacode</tt>
    #
    # == Example
    #
    #  WhitePages.api_key = API_KEY
    #  WhitePages.reverse_address(street: '333 S. 3rd St', city: 'Los Angeles', state: 'CA')
    #
    def reverse_address(options = {})
      fetch(:reverse_address, options)
    end

    protected
    def fetch(method, options)
      options.merge!(api_key: WhitePages.api_key, outputtype: 'JSON')
      response = self.class.get("/#{method}/#{version}", query: options)
      case response.code
      when 200 then Hashie::Mash.new(response)
      else raise WhitePagesError.new(response.headers['x-mashery-error-code'])
      end
    end
  end
end