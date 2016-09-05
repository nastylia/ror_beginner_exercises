require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  validate :name, :presence

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
  
end
