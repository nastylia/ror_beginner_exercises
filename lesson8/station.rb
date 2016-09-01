require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
  end

  def trains
    yield(trains) if block_given? && !trains.empty?
    @trains
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
    puts "Trains on the station #{name}:"
    trains.each { |train| puts "   #{train.name}" }
  end

  def train_departured(train)
    @trains.delete(train)
  end

  private

  def validate!
    raise 'Name cannot be nil' if name.nil?
    raise 'Name cannot be empty' if name.empty?
    true
  end

  #   def list_trains_by_type(type)
  #     trains_to_list = []
  #     @trains.each do |train|
  #       if train.type == type
  #         trains_to_list << train
  #       end
  #     end
  #     puts "List trains by type (#{type}) - #{trains_to_list.length}:"
  #     trains_to_list.each { |train| puts "#{train.name}"}
  #   end
  #
  #   def equal_name_station(station)
  #     self.name == station.name
  #   end
end
