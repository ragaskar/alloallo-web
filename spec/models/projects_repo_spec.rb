require "rails_helper"
require Rails.root.join('spec/support/', 'fake_allocations').to_s

RSpec.describe ProjectsRepo, :type => :model do
  it "returns projects for specific locations" do
    fake_allocations = FakeAllocations.new
    pacifica = Location.new(id: 1, name: "Pacifica")
    pacifica_project = Project.new(id: 3, name: "Kooks Everywhere")
    fake_allocations.add_projects(
      location: pacifica,
      projects: [pacifica_project]
    )

    ob = Location.new(id: 2, name: "OB")
    ob_project = Project.new(id: 4, name: "Shark Sighting")
    fake_allocations.add_projects(
      location: ob,
      projects: [ob_project]
    )

    jetty = Location.new(id: 3, name: "Jetty")
    jetty_project_1 = Project.new(id: 1, name: "Dead Whale")
    jetty_project_2 = Project.new(id: 2, name: "Stairs to Beach")
    fake_allocations.add_projects(
      location: jetty,
      projects: [jetty_project_1, jetty_project_2]
    )

    projects_repo = ProjectsRepo.new(client: fake_allocations.client)
    locations = [pacifica, jetty]
    result = projects_repo.projects(locations: locations)
    expect(result).to match_array([jetty_project_1, jetty_project_2, pacifica_project])
  end
end

