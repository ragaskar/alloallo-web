class Project
  def initialize(id:, name:)
    @id = id
    @name = name
  end
  attr_reader :id

  def as_json(options = {})
    {"id" => @id,
     "name" => @name}
  end

  def to_json
    as_json.to_json
  end

  def ==(other)
    other.is_a?(Project) && other.id == id
  end

end
