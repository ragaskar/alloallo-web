require 'active_support'
require 'active_support/core_ext/object/to_query'
require 'active_support/core_ext/object/blank'
class AllocationsClient
  def initialize(url:, token:)
    @token = token
    @connection = Faraday.new(url)
  end

  def get(endpoint, parameters = {})
    uri = [endpoint, parameters.to_query.presence].join("?")
    response = @connection.get(uri) do |req|
      req.headers['X-Api-Token'] = @token
    end
    JSON.parse(response.body)
  end
end
