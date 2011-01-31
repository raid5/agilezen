module AgileZen
  # AgileZen::Client class.
  class Client
    
    include Projects
    include Stories
    
    attr_accessor :api_key
    attr_accessor :ssl
    
    # Initializer for client.
    def initialize(options ={})
      @api_key = options[:api_key]
      @ssl = options[:ssl]
    end
    
    # Whether the client has the require auth to make API requests.
    def has_required_authentication?
      !@api_key.nil?
    end
    
    # Whether to use SSL or not.
    def has_ssl?
      @ssl
    end
    
    # Set the Faraday::Connection
    def connection=(conn)
      @connection = conn
    end
    
    # Builds and returns the Faraday::Connection based on set options.
    def connection
      @connection ||= Faraday::Connection.new(:url => connection_url, :headers => connection_headers) do |builder|
        builder.adapter Faraday.default_adapter
        #builder.use Faraday::Response::Yajl
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Mashify
      end
    end
    
    # Helper method for determining the correct URL.
    def connection_url
      has_ssl? ? 'https://agilezen.com' : 'http://agilezen.com'
    end
    
    # Helper method for defining globally required headers.
    def connection_headers
      headers = {
        :accept => 'application/json',
        'X-Zen-ApiKey' => @api_key
      }
    end
  end
end