module AgileZen
  # AgileZen::Projects module.
  module Projects
    
    # Retrieve information for all projects.
    def projects(options={})
      response = connection.get do |req|
        req.url "/api/v1/projects", options
      end
      response.body
    end
    
    # Retrieve information for an individual project.
    def project(project_id, options={})
      response_body = nil
      begin
        response = connection.get do |req|
          req.url "/api/v1/project/#{project_id}", options
        end
        response_body = response.body
      rescue MultiJson::DecodeError => e
        #p 'Unable to parse JSON.'
      end
      
      response_body
    end
    
  end
end