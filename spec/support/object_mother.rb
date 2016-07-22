require 'ffaker'

class ObjectMother
  def initialize()
    @project_id = 0;
    @location_id = 0;
    @person_id = 0;
    @allocation_id = 0;
  end

  def project(attrs = {})
    raise ArgumentError.new("Please let your mother pick the ID (don't pass id:)") if attrs[:id]
    name = attrs.fetch(:name, FFaker::Company.name)
    Project.new(id: (@project_id+=1), name: name)
  end

  def location(attrs = {})
    raise ArgumentError.new("Please let your mother pick the ID (don't pass id:)") if attrs[:id]
    name = attrs.fetch(:name, FFaker::Address.city)
    Location.new(id: (@location_id+=1), name: name)
  end

  def timeframe(attrs = {})
    start_date = attrs.fetch(:start_date, Date.today)
    end_date = attrs.fetch(:end_date, nil)
    Timeframe.new(start_date: start_date, end_date: end_date)
  end

  def person(attrs = {})
    name = attrs.fetch(:name, FFaker::Name.name)
    Person.new(id: (@person_id+=1), name: name)
  end

  def allocation(attrs = {})
    person = attrs.fetch(:person, person)
    timeframe = attrs.fetch(:timeframe, timeframe)
    project = attrs.fetch(:project, project)
    Allocation.new(id: (@allocation_id+=1), person: person, timeframe: timeframe, project: project)
  end
end
