class Carriage
  include Manufacturer
  attr_reader :type
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

  def show_free_items_number
    free_item_number
  end

  def show_occupied_items_number
    item_number - free_item_number
  end

  def to_s
    "тип: #{type.to_s}, свободно: #{show_free_items_number}, занято: #{show_occupied_items_number}"
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
    puts "Не хватает свободного места!"
  end

  def free_items?(number)
    free_item_number >= number
  end

  def validate!
    raise "Wrong type, should be cargo or passenger" unless Train::TYPES.include? type.to_sym
    raise "Negative number of volume or seats!" if item_number < 0
    true
  end

end