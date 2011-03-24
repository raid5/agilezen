require "spec_helper"
require File.expand_path('../support/fakeweb_helper', __FILE__)

describe AgileZen::Stories do
  
  before(:each) do
    @client = AgileZen::Client.new(:api_key => 'testapikey')      
  end
  
  describe "#stories" do
    context "success" do
      it "performs an API request for all story of a given project" do
        register_get('https://agilezen.com/api/v1/projects/123/stories', 'stories.json')

        response = @client.project_stories(123)

        response.items.story.first.text.should eq('End world hunger')
      end
      
      it "pages stories" do
        register_get('https://agilezen.com/api/v1/projects/15404/stories?page=1&pageSize=3', 'stories-page1.json')
        register_get('https://agilezen.com/api/v1/projects/15404/stories?page=2&pageSize=3', 'stories-page2.json')
        
        response1 = @client.project_stories(15404, :page => 1, :pageSize => 3)
        response2 = @client.project_stories(15404, :page => 2, :pageSize => 3)
        
        response1.items.should_not eql(response2.items)
      end
    end
    
    context "failure" do
      it "returns nil to indicate failure" do
        register_get('https://agilezen.com/api/v1/projects/99999/stories', 'garbage.txt')

        response = @client.project_stories(99999)

        response.should be_nil
      end
    end
  end
  
  describe "#story" do
    context "success" do
      it "performs an API request for a single story of a given project" do
        register_get('https://agilezen.com/api/v1/projects/123/story/321', 'story.json')

        response = @client.project_story(123, 321)

        response.id.should eq(321)
        response.text.should eq('Feed the children')
      end
      
      it "includes enrichments" do
        register_get('https://agilezen.com/api/v1/projects/15404/story/2?with=details%2Ctags%2Cmetrics', 'story/2-with-enrichments.json')

        response = @client.project_story(15404, 2, :with => 'details,tags,metrics')
        
        response.details.should_not be_nil
        response.tags.should_not be_nil
        response.metrics.should_not be_nil
      end
      
      it "allows filtering" do
        register_get('https://agilezen.com/api/v1/projects/15404/story/2?where=tag%3Aauthentication&with=tags', 'story/2-with-filtering.json')

        response = @client.project_story(15404, 2, :where => 'tag:authentication', :with => 'tags')
        
        response.id.should == 2
        response.tags.detect { |t| t.name == 'authentication' }.should_not be_nil
      end
    end

    context "failure" do
      it "returns nil to indicate failure" do
        register_get('https://agilezen.com/api/v1/projects/99999/story/11111', 'garbage.txt')

        response = @client.project_story(99999, 11111)

        response.should be_nil
      end
    end
  end
  
end