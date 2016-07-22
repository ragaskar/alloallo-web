require "rails_helper"
require Rails.root.join('spec/support/', 'fake_allocations').to_s

RSpec.describe ProjectsRepo, :type => :model do

  before do
    @object_mother = ObjectMother.new
    @fake_allocations = FakeAllocations.new

    @pacifica = @object_mother.location(name: "Pacifica")
    @pacifica_project = @object_mother.project(name: "Kooks Everywhere")
    @fake_allocations.add_project(location: @pacifica, project: @pacifica_project)
    @ob = @object_mother.location(name: "OB")
    @ob_project = @object_mother.project(name: "Shark Sighting")
    @fake_allocations.add_project(location: @ob, project: @ob_project)

    @jetty = @object_mother.project(name: "Jetty")
    @jetty_project_1 = @object_mother.project(name: "Dead Whale")
    @jetty_project_2 = @object_mother.project(name: "Stairs to Beach")
    @fake_allocations.add_project(location: @jetty, project: @jetty_project_1)
    @fake_allocations.add_project(location: @jetty, project: @jetty_project_2)
  end

  it "returns projects for specific locations" do
    projects_repo = ProjectsRepo.new(client: @fake_allocations.client)
    result = projects_repo.projects(locations: [@pacifica, @jetty])
    expect(result).to match_array([@jetty_project_1, @jetty_project_2, @pacifica_project])
  end


end

