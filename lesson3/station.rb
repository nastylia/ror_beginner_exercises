class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrived(train)
    @trains << train
    puts "Прибыл поезд #{train.id} на станцию #{name}"
  end

  def train_departured(train)
    puts "Поезд отправлен #{train.id} со станции #{name}" if @trains.delete(train)
  end

  def list_trains_by_type(type)
    trains_to_list = []
    @trains.each do |train|
      if train.type == type
        trains_to_list << train
      end
    end
    puts "Список поездов по типу(#{type}) - #{trains_to_list.length}:"
    trains_to_list.each { |train| puts "#{train.id}"}
  end

  def equal_name_station(station)
    self.name == station.name
  end

end