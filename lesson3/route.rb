class Route
  attr_reader :stations, :current_station
  #attr_writer :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    @stations.insert(-2, station)
    puts "Новая станция добавлена: #{station.name}"
  end

  def delete_station(name)
    index_to_delete = nil
    stations[1..-2].each_with_index do |s, index|
      index_to_delete = index + 1 if s.name == name
    end

    if index_to_delete
      @stations.delete_at(index_to_delete)
      puts "Станция удалена успешно: #{name}"
    else
      puts "Станция #{name} либо промежуточная, либо нет такой."
    end
  end

  def list_stations
    stations.each {|station| puts "#{station.name}"}
  end


  def get_next_station(station_index)
    if @stations[station_index + 1]
      return station_index + 1
    end
    station_index
  end

  def get_prev_station(station_index)
    if station_index > 0  
      return station_index - 1
    end
    station_index
  end

  def get_station(station_index)
    @stations[station_index] if station_index >= 0
  end

  def to_s
    @stations.each do |st| puts st.to_s end
  end
end