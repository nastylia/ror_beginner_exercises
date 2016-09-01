class CargoCarriage < Carriage
  def initialize(carriage_volume)
    super(:cargo, carriage_volume)
  end

  def take_volume(volume)
    occupy_items(volume)
  end
end
