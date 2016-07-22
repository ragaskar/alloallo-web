require 'rails_helper'
require Rails.root.join('spec/support/', 'fake_allocations').to_s
require Rails.root.join('spec/support/', 'object_mother').to_s

describe FakeAllocations do

  describe "Projects" do
    before do
      fake_allocations = FakeAllocations.new
      object_mother = ObjectMother.new
      @pacifica = object_mother.location(name: "Pacifica")
      @pacifica_project = object_mother.project(name: "Kooks Everywhere")
      fake_allocations.add_projects(
        location: @pacifica,
        projects: [@pacifica_project]
      )
      @jetty = object_mother.location(name: "Jetty")
      @jetty_project = object_mother.project(name: "Dead Whale")
      fake_allocations.add_projects(
        location: @jetty,
        projects: [@jetty_project]
      )

      @fake_client = fake_allocations.client
    end
    it "fake allocations client can return all projects" do
      result = @fake_client.get("/api/projects")
      expect(result).to match_array([@pacifica_project.as_json, @jetty_project.as_json])

    end

    it "fake allocations client can fetch a single project" do
      result = @fake_client.get("/api/projects/#{@pacifica_project.id}")
      expect(result).to eq(@pacifica_project.as_json)
    end

    it "fake allocations client can fetch projects by location" do
      result = @fake_client.get("/api/projects", location_ids: [@pacifica.id])
      expect(result).to match_array([@pacifica_project.as_json])

    end

    it "fake allocations client can fetch a project by location and time" do

    end
  end
end
