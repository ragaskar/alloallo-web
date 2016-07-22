class LocationsRepo
  def initialize(client:)
    @client = client
  end

  def locations
    location_data = @client.get("/api/locations")
    location_data.map do |location|
      Location.new(location.symbolize_keys)
    end
  end
end
