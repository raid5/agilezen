require "spec_helper"
require File.expand_path('../support/fakeweb_helper', __FILE__)

describe AgileZen::Projects do
  
  before(:each) do
    @client = AgileZen::Client.new(:api_key => 'testapikey')      
  end
  
  describe "#projects" do
    context "success" do
      it "performs an API request for all projects" do
        register_get('https://agilezen.com/api/v1/projects', 'projects.json')

        response = @client.projects

        response.items.first.name.should eq('Sudden Valley')
      end
      
      it "allows filtering" do
        register_get('https://agilezen.com/api/v1/projects?where=name%3ADiff', 'projects-with-filtering.json')

        response = @client.projects(:where => 'name:Diff')
        
        response.items.first.name.should =~ /Diff/i
      end
    end
  end
  
  describe "#project" do
    context "success" do
      it "performs an API request for a single project" do
        register_get('https://agilezen.com/api/v1/projects/1', 'project.json')

        response = @client.project(1)

        response.id.should eq(1)
        response.name.should eq('Sudden Valley')
      end
      
      it "includes enrichments" do
        register_get('https://agilezen.com/api/v1/projects/15404?with=details%2Cphases%2Cmembers%2Croles%2Cinvites%2Cmetrics', 'project/15404-with-enrichments.json')

        response = @client.project(15404, :with => 'details,phases,members,roles,invites,metrics')
        
        response.details.should_not be_nil
        response.phases.should_not be_nil
        response.members.should_not be_nil
        response.roles.should_not be_nil
        response.invites.should_not be_nil
        response.metrics.should_not be_nil
      end
    end
    
    context "failure" do
      it "returns nil to indicate failure" do
        register_get('https://agilezen.com/api/v1/projects/99999', 'garbage.txt')

        response = @client.project(99999)

        response.should be_nil
      end
    end
  end
  
end