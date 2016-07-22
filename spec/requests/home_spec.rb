require "rails_helper"
require Rails.root.join('spec/support/', 'fake_allocations').to_s
require Rails.root.join('spec/support/', 'object_mother').to_s

RSpec.describe "Home page", :type => :request do
  before do
    ENV["BASIC_AUTH_USERNAME"] = "GOOD"
    ENV["BASIC_AUTH_PASSWORD"] = "CREDS"
    ENV["ALLOCATIONS_API_URL"] = "https://example.com"
    ENV["ALLOCATIONS_API_TOKEN"] = "token"

    allocations = FakeAllocations.new
    object_mother = ObjectMother.new
    august_1 = Date.parse("August 1, 2016")
    august_6 = Date.parse("August 6, 2016")
    starting_this_week = object_mother.timeframe(start_date: august_1, end_date: nil)
    kelly_slater = object_mother.person(name: "Kelly Slater")
    wave_pool = object_mother.project(name: "KSWaveCo")
    @lemoore = object_mother.location(name: "Lemoore")
    new_cf_hire = object_mother.allocation(person: kelly_slater, project: wave_pool, location: @lemoore, timeframe: starting_this_week)
    allocations.add_allocation(new_cf_hire)
    allow(AllocationsClient).to receive(:new).with(
      url: "https://example.com",
      token: "token"
    ).and_return(allocations.client)
  end

  describe "Authentication" do
    it "refuses index for unauthenticated users" do
      get "/", headers: {}
      expect(response.status).to eq(401)
    end

    it "refuses index for unauthorized users" do
      get "/", headers: {"HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("BAD","CREDS")}
      expect(response.status).to eq(401)
    end

    it "permits access for authorized users" do
      get "/", headers: {"HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("GOOD","CREDS")}
      expect(response.status).to eq(200)
    end
  end

  describe "Content" do
    it "should include expected allocations data" do
      pending "steel thread"
      get "/", params: {location_ids: [@lemoore.id]}, headers: {"HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("GOOD","CREDS")}
      expect(response.body).to eq(/Kelly Slater.*Wave Pool/)
    end
  end

end
