class Allocation
  def initialize(id:, timeframe:, project:, person:, location:)
    @id = id
    @project = project
    @location = location
    @person = person
    @timeframe = timeframe
  end
  attr_reader :id, :project

  def ==(other)
    other.is_a?(Allocation) && other.id == id
  end

end
