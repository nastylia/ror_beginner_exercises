class Carriage
  include Manufacturer
  attr_reader :type, :free_item_number
  def initialize(type, item_number)
    @type = type
    @item_number = item_number
    @free_item_number = item_number
    validate!
  end

  def valid?
    validate!
  rescue
    true
  end

  def booked_item_number
    item_number - free_item_number
  end

  def to_s
    "type: #{type}, free: #{free_item_number}, booked: #{booked_item_number}"
  end

  def cargo_type?
    type == :cargo
  end

  protected

  def occupy_items(number)
    if free_items? number
      occupy! number
    else
      no_free_items
    end
  end

  private

  attr_reader :item_number, :free_item_number
  attr_writer :free_item_number

  def occupy!(number)
    self.free_item_number -= number
  end

  def no_free_items
    puts 'Not enough free space!'
  end

  def free_items?(number)
    free_item_number >= number
  end

  def validate!
    raise 'Wrong type of carriage!' unless Train::TYPES.include? type.to_sym
    raise 'Negative number of volume or seats!' if item_number < 0
    true
  end
end
