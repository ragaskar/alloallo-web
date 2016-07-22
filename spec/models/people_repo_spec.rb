require "rails_helper"
require Rails.root.join('spec/support/', 'fake_allocations').to_s
require Rails.root.join('spec/support/', 'object_mother').to_s

RSpec.describe PeopleRepo, :type => :model do
  it "returns person for the passed id" do
    fake_allocations = FakeAllocations.new
    object_mother = ObjectMother.new
    joel_tudor = object_mother.person(name: "Joel Tudor")
    fake_allocations.add_people([joel_tudor])

    people_repo = PeopleRepo.new(client: fake_allocations.client)
    result = people_repo.person(joel_tudor.id)
    expect(result).to eq(joel_tudor)
  end

  it "caches people once retrieved" do
    fake_allocations = FakeAllocations.new
    object_mother = ObjectMother.new
    joel_tudor = object_mother.person(name: "Joel Tudor")
    fake_allocations.add_people([joel_tudor])

    people_repo = PeopleRepo.new(client: fake_allocations.client)
    first_result = people_repo.person(joel_tudor.id)
    expect(first_result).to eq(joel_tudor)
    second_result = people_repo.person(joel_tudor.id)
    expect(first_result.object_id).to eq(second_result.object_id)
  end
end

