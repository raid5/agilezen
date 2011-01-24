module AgileZen
  module Projects
    
    def projects(options={})
      #connection.get('/api/v1/projects').body
      
      response = connection.get do |req|
        req.url "/api/v1/projects", options
      end
      response.body
    end
    
    def project(project_id)
      connection.get("/api/v1/project/#{project_id}").body
    end
    
  end
end