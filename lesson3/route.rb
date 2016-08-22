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

  def delete_station(station)

    #check that station to delete is not the last or the first
    if stations.last.equal_name_station(station) || stations.first.equal_name_station(station)
      puts "Станция #{station.name} не промежуточная!"
    elsif @stations.delete(station)
      puts "Станция удалена успешно: #{station.name}"
    else
      puts "Станции #{station.name} нет."
    end
  end

  def list_stations
    stations.each {|station| puts "#{station.name}"}
  end


  def get_next_station_index(station_index)
    if @stations[station_index + 1]
      return station_index + 1
    end
    station_index
  end

  def get_prev_station_index(station_index)
    if station_index > 0  
      return station_index - 1
    end
    station_index
  end

  def get_station(station_index)
    @stations[station_index] if station_index >= 0
  end

end