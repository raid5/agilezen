module AgileZen
  class Client
    
    include Projects
    include Stories
    
    attr_accessor :api_key
    attr_accessor :ssl
    
    def initialize(options ={})
      @api_key = options[:api_key]
      @ssl = options[:ssl]
    end
    
    def has_required_authentication?
      !@api_key.nil?
    end
    
    def has_ssl?
      @ssl
    end
    
    def connection=(conn)
      @connection = conn
    end
    
    def connection
      @connection ||= Faraday::Connection.new(:url => connection_url, :headers => connection_headers) do |builder|
        builder.adapter Faraday.default_adapter
        #builder.use Faraday::Response::Yajl
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Mashify
      end
    end
    
    def connection_url
      has_ssl? ? 'https://agilezen.com' : 'http://agilezen.com'
    end
    
    def connection_headers
      headers = {
        :accept => 'application/json',
        'X-Zen-ApiKey' => @api_key
      }
    end
    
  end
end