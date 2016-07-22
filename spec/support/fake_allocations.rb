require_relative "fake_allocations_client"

class FakeAllocations

  def initialize()
    @projects = []
    @locations = []
    @people = []
    @project_allocations = {}
    @project_ids_by_location_id = {}
  end

  def add_allocation(allocation)
    @project_allocations[allocation.project.id] = allocation
  end

  def add_locations(locations)
    @locations += locations
  end

  def add_projects(location:, projects:)
    raise ArgumentError.new("projects should be an array") unless projects.is_a?(Array)
    raise ArgumentError.new("location should") unless projects.is_a?(Array)
    @projects += projects
    @locations.push(location)
    @project_ids_by_location_id[location.id] = projects.map(&:id)
  end

  def all_projects(params)
    filtered_projects = @projects
    if (params[:location_ids])
      project_ids_filtered_by_location = params[:location_ids].collect { |location_id| @project_ids_by_location_id[location_id] }.flatten
      filtered_projects = @projects.select { |p| project_ids_filtered_by_location.include?(p.id) }
    end
    filtered_projects
  end

  def all_locations
    @locations
  end

  def project(id)
    @projects.detect { |p| p.id == id }
  end

  def client
    FakeAllocationsClient.new(self)
  end

end
