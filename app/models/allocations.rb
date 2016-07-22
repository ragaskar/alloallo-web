class Allocations
  def initialize(token:, url:)
    client = AllocationsClient.new(token: token, url: url)
    @projects_repo = ProjectsRepo.new(client: client)
    @locations_repo = LocationsRepo.new(client: client)
    @people_repo = PeopleRepo.new(client: client)
  end

  def allocations_for_locations(location_ids:, start_on:, end_on: )
    locations = @locations_repo.locations
    allocations = []

    location_ids.each do |location_id|
      location = locations.first { |l| l.id == location_id }
      projects = @projects_repo.projects(locations: [location], start_on: start_on, end_on: end_on)
      projects.each do |project|
        project_week_allocations = @project_allocations_repo.project_allocations(project: project, start_on: start_on, end_on: end_on)
        project_week_allocations.each do |project_week|
          timeframe = Timeframe.new(start_date: Date.parse(project_week.start_on), end_date: Date.parse(project_week.end_on))
          project_week.people.each do |person_id|
            person = @people_repo.person(person_id)
            allocations += Allocations.new(person: person, project: project, location: location, timeframe: timeframe)
          end
        end
      end
    end
    allocations
  end

end
