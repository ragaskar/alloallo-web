class FakeAllocationsClient

  def initialize(fake_allocations)
    @fake_allocations = fake_allocations
  end

  def get(endpoint, params = {})
    function_to_call, arguments = endpoint_map(endpoint)
    raise ArgumentError.new("Unknown Endpoint #{endpoint}") unless function_to_call
    JSON.parse(send(function_to_call, arguments, params).to_json)
  end

  private
  def all_projects(arguments, params = {})
    @fake_allocations.all_projects(params)
  end

  def project(arguments, params ={})
    id = arguments.first.to_i
    @fake_allocations.project(id)
  end

  def endpoint_map(endpoint)
    map = {
      "/api/projects$" => "all_projects",
      "/api/projects/(\\d+)$" => "project"
    }
    map.keys.each do |key|
      match_data = endpoint.match(key)
      if match_data
        return map[key], match_data.captures
      end
    end
    nil #if no match
  end

end
