require 'date'

class Timeframe
  def initialize(start_date:, end_date:)
    raise ArgumentError.new("start_date must be a Monday") unless start_date.monday?
    raise ArgumentError.new("end_date must be a Sunday or nil") unless end_date.nil? || end_date.sunday?
    @start_date = start_date
    @end_date = end_date
  end

end
