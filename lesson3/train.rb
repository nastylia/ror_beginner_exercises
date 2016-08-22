class Train
  attr_accessor :type
  attr_reader :id

  #attr_reader :speed, :carriage_number
  def initialize(id, type, carriage_number)
    @id = id
    @type = type
    @carriage_number = carriage_number
    @speed = 0
  end

  def speed_up(speed)
    @speed += speed
  end

  def speed_down(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def speed
    puts "Текущая скорость #{@speed}"
  end

  def add_carriage
    @carriage_number += 1 if @speed == 0
  end

  def delete_carriage
    @carriage_number -= 1 if @speed == 0 && @carriage_number > 0
  end

  def carriage_number
    puts "Количество вагонов в поезде #{@carriage_number}"
  end

  def add_route(route)
    @route = route
    @current_station = 0;
    @route.get_station(@current_station).train_arrived(self)
  end

  def move_next_station
    return puts "Нет маршрута у поезда" unless @route
    next_station = @route.get_next_station_index(@current_station)
    if next_station == @current_station
      puts "Поезд уже на конечной станции"
    else
      @route.get_station(@current_station).train_departured(self)
      @current_station = next_station
      @route.get_station(@current_station).train_arrived(self)
    end
  end

  def move_prev_station
    return puts "Нет маршрута у поезда" unless @route
    prev_station = @route.get_prev_station_index(@current_station)
    if prev_station == @current_station
      puts "Поезд уже на начальной станции"
    else
      @route.get_station(@current_station).train_departured(self)
      @current_station = prev_station
      @route.get_station(@current_station).train_arrived(self)
    end
  end

  def show_current_station
    return puts "Нет маршрута у поезда" unless @route
    puts "Текущая станция: #{@route.get_station(@current_station).name}"
  end

  def show_next_station
    return puts "Нет маршрута у поезда" unless @route
    next_station = @route.get_station(@current_station + 1)
    puts "Следующая станция: #{next_station.name}" if next_station
  end

  def show_prev_station
    return puts "Нет маршрута у поезда" unless @route
    prev_station = @route.get_station(@current_station - 1)
    puts "Предыдущая станция: #{prev_station.name}" if prev_station
  end

end