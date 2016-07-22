class PeopleRepo
  def initialize(client:)
    @client = client
    @cache = {} #need this because no way to bulk get people
  end

  def person(person_id)
    return @cache[person_id] if @cache[person_id]
    person_data = @client.get("/api/people/#{person_id}")
    person = Person.new(person_data.symbolize_keys)
    @cache[person_id] = person
    person
  end
end
