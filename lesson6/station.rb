require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  def validate!
    raise "Name cannot be nil" if name.nil?
    raise "Name cannot be empty" if name.empty?
    true
  end

  def valid?
    validate!
  rescue
    false
  end

  def train_arrived(train)
    @trains << train
  end

  def list_trains_on_station
    puts "Список поездов на станции #{name}:"
    trains.each { |train| puts "   #{train.name}"}
  end

  def train_departured(train)
    @trains.delete(train)
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