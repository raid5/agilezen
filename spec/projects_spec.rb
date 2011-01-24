require "spec_helper"
require File.expand_path('../support/fakeweb_helper', __FILE__)

describe AgileZen::Projects do
  
  describe "#projects" do
    it "performs an API request for all projects" do
      register_get('http://agilezen.com/api/v1/projects', 'projects.json')
      
      client = AgileZen::Client.new(:api_key => 'testapikey')

      response = client.projects
      
      response.projects.items.project.first.name.should eq('World Peace')
    end
  end
  
  describe "#project" do
    it "performs an API request for a single project" do
      register_get('http://agilezen.com/api/v1/project/123', 'project.json')
      
      client = AgileZen::Client.new(:api_key => 'testapikey')

      response = client.project(123)
      
      response.id.should eq(123)
      response.name.should eq('Hippie Peace')
    end
  end
  
end