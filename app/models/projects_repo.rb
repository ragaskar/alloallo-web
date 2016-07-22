class ProjectsRepo
  def initialize(client:)
    @client = client
  end

  def projects_for(locations:)
    project_data = @client.get("/api/projects", location_ids: locations.map(&:id))
    project_data.map do |project|
      Project.new(project.symbolize_keys)
    end
  end
end
