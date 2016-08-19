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

  def list_trains_by_type
    passenger_trains = []
    cargo_trains = []
    @trains.each do |train|
      if train.type == "cargo"
        cargo_trains << train
      else
        passenger_trains << train
      end
    end
    puts "Пассажирские поезда - #{passenger_trains.length}:"
    passenger_trains.each { |train| puts "#{train.id}"}
    puts "Грузовые поезда - #{cargo_trains.length}:"
    cargo_trains.each { |train| puts "#{train.id}"}
  end


end