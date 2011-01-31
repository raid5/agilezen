# AgileZen - A Ruby wrapper for the AgileZen API (v1.0)

## Installation

    gem install agilezen

## Usage

When setting up the client, just specify your api key. Methods that are designed to take options in the API are designed that way in the wrapper also, as you'd expect. For more details, read the AgileZen API [documentation](https://agilezen.tenderapp.com/kb/api/overview).

    require 'agilezen'
    
    # Setup the client
    client = AgileZen::Client.new(:api_key => 'yourapikey')
    
    # Returns info for all your projects
    projects = @client.projects
    
    # Returns info for the specified project
    project = @client.project(123)
    
    # Returns info for all stories for the specified project
    stories = @client.projects_stories(123)
    
    # Returns info for a specific story within a project
    story = @client.project_story(123, 5)
    
    # Collection resources support pagination
    stories = @client.projects_stories(123, :page => 2, :pageSize => 50)
    
    # Enrichments are supported for additional details
    stories = @client.projects_stories(123, :with => 'details,tags')
    
    # Filters are supported to limit your queries
    stories = @client.projects_stories(123, :where => 'tag:authentication')
     
## Documentation

For additional details, checkout the latest generated [documentation](http://raid5.github.com/agilezen).
