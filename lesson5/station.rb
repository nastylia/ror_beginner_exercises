class Station
  attr_reader :name, :trains
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
  end

  def train_arrived(train)
    @trains << train
    puts "Прибыл поезд #{train.name} на станцию #{name}"
  end

  def list_trains_on_station
    puts "Список поездов на станции #{name}:"
    trains.each { |train| puts "   #{train.name}"}
  end

  def train_departured(train)
    puts "Поезд отправлен #{train.name} со станции #{name}" if @trains.delete(train)
  end

  def self.all
    @@all_stations
  end

=begin
  def list_trains_by_type(type)
    trains_to_list = []
    @trains.each do |train|
      if train.type == type
        trains_to_list << train
      end
    end
    puts "Список поездов по типу(#{type}) - #{trains_to_list.length}:"
    trains_to_list.each { |train| puts "#{train.name}"}
  end

  def equal_name_station(station)
    self.name == station.name
  end
=end

end