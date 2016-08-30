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


  protected

  def occupy_items(number)
    if free_items? number
      occupy! number
    else
      no_free_items
    end
  end

  def show_free_items_number(message)
    puts "#{message}: #{free_item_number}"
  end

  def show_occupied_items_number(message)
    puts "#{message}: #{item_number - free_item_number}"
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
    true
  end

end