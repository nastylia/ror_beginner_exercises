require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  TYPES = [:cargo, :passenger].freeze
  NAME_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i

  attr_reader :name, :train_type, :speed
  attr_accessor :current_station, :carriages

  validate :name, :presence
  validate :name, :format, NAME_FORMAT
  validate :train_type, :type, TYPES

  def initialize(name, type)
    @name = name
    @train_type = type
    validate!
    @carriages = {}
    @speed = 0
    @current_station = nil
    register_instance
  end

  def to_s
    "Train id: #{name}, type: #{train_type}, carriages\' number: #{carriages.length}"
  end

  def carriages
    yield(carriages) if block_given? && !carriages.empty?
    @carriages
  end

  def cargo_type?
    train_type == :cargo
  end

  def speed_up(speed)
    @speed += speed
  end

  def speed_down(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def show_speed
    puts "Current speed #{@speed}"
  end

  def add_carriage(carriage)
    carriages[carriages.length.to_s] = carriage if train_type == carriage.type
  end

  def delete_carriage
    carriages.shift if speed.zero?
  end

  def carriage_number
    carriages.length
  end

  def move_to_station(station)
    current_station.train_departured(self) if current_station
    station.train_arrived(self)
    self.current_station = station
  end
end
