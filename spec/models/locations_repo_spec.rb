require "rails_helper"
require Rails.root.join('spec/support/', 'fake_allocations').to_s
require Rails.root.join('spec/support/', 'object_mother').to_s

RSpec.describe LocationsRepo, :type => :model do
  it "returns locations for specific locations" do
    fake_allocations = FakeAllocations.new
    object_mother = ObjectMother.new
    pacifica = object_mother.location(name: "Pacifica")
    jetty = object_mother.location(name: "Jetty")
    fake_allocations.add_locations([pacifica, jetty])
    locations_repo = LocationsRepo.new(client: fake_allocations.client)
    result = locations_repo.locations
    expect(result).to match_array([pacifica, jetty])
  end
end

