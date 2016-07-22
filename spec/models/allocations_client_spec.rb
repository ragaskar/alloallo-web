require "rails_helper"

RSpec.describe AllocationsClient, :type => :model do
  describe "get" do
    before do
      @expected_response = {"cool" => "data"}
      stub_request(:get, /example.com\/cool_endpoint/).to_return(body: @expected_response.to_json)
    end
    it "uses the passed token when making requests" do
      client = AllocationsClient.new(url: "http://example.com", token: "token")
      response = client.get("/cool_endpoint")
      expect(response).to eq(@expected_response)
      expect(WebMock).to have_requested(:get, "http://example.com/cool_endpoint").
        with(headers: {'X-Api-Token' => "token"})
    end

    it "permits passing of url parameters" do
      client = AllocationsClient.new(url: "http://example.com", token: "token")
      response = client.get("/cool_endpoint", {rad: "parameters", cool: ["extra", "stuff"]})
      expect(response).to eq(@expected_response)
      expect(WebMock).to have_requested(:get, "http://example.com/cool_endpoint?rad=parameters&cool[]=extra&cool[]=stuff").
        with(headers: {'X-Api-Token' => "token"})
    end
  end
end

