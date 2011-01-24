module AgileZen
  module Stories
    
    def project_stories(project_id)
      connection.get("/api/v1/project/#{project_id}/stories").body
    end
    
    def project_story(project_id, story_id)
      connection.get("/api/v1/project/#{project_id}/story/#{story_id}").body
    end
    
  end
end