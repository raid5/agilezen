require "spec_helper"

describe AgileZen::Client do
  
  describe "#initialize" do
    it "stores the api key" do
      client = AgileZen::Client.new(:api_key => 'testapikey')
      client.api_key.should_not be_nil
    end
  end
  
  describe "#has_required_authentication?" do
    it "checks that the api key exists" do
      client = AgileZen::Client.new(:api_key => 'testapikey')
      client.should have_required_authentication
    end
  end
  
  describe "#connection" do
    context "building the Faraday::Connection" do
      it "instantiates a Faraday::Connection" do
        client = AgileZen::Client.new(:api_key => 'testapikey')
        client.connection.should be_a(Faraday::Connection)
      end
      
      it "configures the url" do
        client = AgileZen::Client.new(:api_key => 'testapikey')
        client.connection.host.should_not be_nil
      end

      it "configures any default headers" do
        client = AgileZen::Client.new(:api_key => 'testapikey')
        client.connection.headers.should_not be_empty
      end
    end
  end
  
  describe "#connection_url" do
    it "uses ssl" do
      client = AgileZen::Client.new(:api_key => 'testapikey')
      client.connection_url.should eq('https://agilezen.com')
    end
  end
  
  describe "#connection_headers" do
    it "sets the Accept header to JSON" do
      client = AgileZen::Client.new(:api_key => 'testapikey')
      client.connection_headers.should have_key(:accept)
      client.connection_headers.should have_value('application/json')
    end
    
    it "sets the X-Zen-ApiKey header" do
      client = AgileZen::Client.new(:api_key => 'testapikey')
      client.connection_headers.should have_key('X-Zen-ApiKey')
      client.connection_headers.should have_value(client.api_key)
    end
  end
  
end