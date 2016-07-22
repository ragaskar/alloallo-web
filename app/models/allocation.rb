class Allocation
  def initialize(id:, timeframe:, project:, person:)
    @id = id
    @project = project
    @person = person
    @timeframe = timeframe
  end
  attr_reader :id, :project

  def ==(other)
    other.is_a?(Allocation) && other.id == id
  end

end
