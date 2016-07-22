class HomeController < ApplicationController
  http_basic_authenticate_with name: ENV["BASIC_AUTH_USERNAME"], password: ENV["BASIC_AUTH_PASSWORD"]

  def index
    allocations = Allocations.new(token:ENV["ALLOCATIONS_API_TOKEN"], url: ENV["ALLOCATIONS_API_URL"])
    today = Date.today
    filters = {
      location_ids: params["location_ids"],
      start_on: today.beginning_of_week,
      end_on: today.end_of_week
    }
    allocations = allocations.allocations_for_locations(filters)
    # @allocations_presenter = CloudFoundryWeeklyUpdateAllocationsPresenter.new(allocations)
  end
end
