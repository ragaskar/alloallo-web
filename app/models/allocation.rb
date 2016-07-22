class Allocation
  def initialize(timeframe:, project:, person:, location:)
    @project = project
    @location = location
    @person = person
    @timeframe = timeframe
  end
  attr_reader :id, :project

  def ==(other)
    other.is_a?(Allocation) && other.id == id && other.person.id == person.id && other.project.id == project.id
  end

end
