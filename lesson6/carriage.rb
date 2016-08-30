class Carriage
  include Manufacturer
  attr_reader :type
  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
  rescue
    true
  end

  private

  def validate!
    raise "Wrong type, should be cargo or passenger" unless Train::TYPES.include? type.to_sym
    true
  end
end