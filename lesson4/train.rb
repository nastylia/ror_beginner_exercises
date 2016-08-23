class Train
  attr_reader :name
  attr_reader :type, :speed
  attr_accessor :current_station

  def initialize(name, type)
    @name = name
    @carriages = []
    @type = type
    @speed = 0
    @current_station = nil
  end

  def speed_up(speed)
    @speed += speed
  end

  def speed_down(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def show_speed
    puts "Текущая скорость #{@speed}"
  end

  def add_carriage(carriage)
    @carriages << carriage if type == carriage.type
  end

  def delete_carriage
    puts "Вагон успешно удален" if speed == 0 && @carriages.pop
  end

  def carriage_number
    puts "Количество вагонов в поезде #{@carriages.length}"
  end

  def move_to_station(station)
    current_station.train_departured(self) if current_station
    station.train_arrived(self)
    self.current_station = station
  end

 # def cargo_type?
 #   type == "cargo"
 # end
=begin
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
=end

end