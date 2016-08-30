class PassengerCarriage < Carriage
  def initialize(seat_number)
    super(:passenger, seat_number)
  end

  def take_a_seat
    occupy_items(1)
  end

  def show_free_seats_number
    show_free_items_number("Количество свободных мест в вагоне")
  end

  def show_occupied_seats_number
    show_occupied_items_number("Количество занятых мест в вагоне")
  end
end