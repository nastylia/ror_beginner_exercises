class PassengerCarriage < Carriage
  def initialize(seat_number)
    super(:passenger, seat_number)
  end

  def take_a_seat
    occupy_items(1)
  end
end
