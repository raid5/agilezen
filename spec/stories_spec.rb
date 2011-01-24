require "spec_helper"
require File.expand_path('../support/fakeweb_helper', __FILE__)

describe AgileZen::Stories do
  
  describe "#stories" do
    it "performs an API request for all story of a given project" do
      register_get('http://agilezen.com/api/v1/project/123/stories', 'stories.json')
      
      client = AgileZen::Client.new(:api_key => 'testapikey')

      response = client.project_stories(123)
      
      response.items.story.first.text.should eq('End world hunger')
    end
  end
  
  describe "#story" do
    it "performs an API request for a single story of a given project" do
      register_get('http://agilezen.com/api/v1/project/123/story/321', 'story.json')
      
      client = AgileZen::Client.new(:api_key => 'testapikey')

      response = client.project_story(123, 321)
      
      response.id.should eq(321)
      response.text.should eq('Feed the children')
    end
  end
  
end