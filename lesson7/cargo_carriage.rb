class CargoCarriage < Carriage
  def initialize(carriage_volume)
    super(:cargo, carriage_volume)
  end

  def take_volume(volume)
    occupy_items(volume)
  end

  def show_free_volume_number
    show_free_items_number("Доступный объем в вагоне")
  end

  def show_occupied_volume_number
    show_occupied_items_number("Занятый объем в вагоне")
  end
end