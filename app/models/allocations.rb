class Allocations
  def initialize(token:, url:)
    client = AllocationsClient.new(token: token, url: url)
    @projects_repo = ProjectsRepo.new(client: client)
    @locations_repo = LocationsRepo.new(client: client)
  end

  def allocations_for_locations(location_ids:, start_on:, end_on: )
    locations = @locations_repo.locations
  end

end
