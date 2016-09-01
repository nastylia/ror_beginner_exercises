require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter

  TYPES = [:cargo, :passenger].freeze
  NAME_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i

  attr_reader :name, :type, :speed
  attr_accessor :current_station, :carriages

  def initialize(name, type)
    @name = name
    @type = type
    validate!
    @carriages = {}
    @speed = 0
    @current_station = nil
    register_instance
  end

  def to_s
    "Train id: #{name}, type: #{type}, carriages\' number: #{carriages.length}"
  end

  def carriages
    yield(carriages) if block_given? && !carriages.empty?
    @carriages
  end

  def cargo_type?
    type == :cargo
  end

  def valid?
    validate!
  rescue
    false
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
    carriages[carriages.length.to_s] = carriage if type == carriage.type
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

  private

  def validate!
    raise 'Name cannot be nil' if name.nil?
    raise 'Name cannot be empty' if name.empty?
    raise 'Wrong type format for train name!' if name !~ NAME_FORMAT
    raise 'Wrong typeof train!' unless TYPES.include? type.to_sym
    true
  end

  # def cargo_type?
  #   type == "cargo"
  # end
  #   def add_route(route)
  #     @route = route
  #     @current_station = 0;
  #     @route.get_station(@current_station).train_arrived(self)
  #   end
  #
  #   def move_next_station
  #     return puts "Train has no route" unless @route
  #     next_station = @route.get_next_station_index(@current_station)
  #     if next_station == @current_station
  #       puts "Train is already at the end of the route"
  #     else
  #       @route.get_station(@current_station).train_departured(self)
  #       @current_station = next_station
  #       @route.get_station(@current_station).train_arrived(self)
  #     end
  #   end
  #
  #   def move_prev_station
  #     return puts "Train has no route" unless @route
  #     prev_station = @route.get_prev_station_index(@current_station)
  #     if prev_station == @current_station
  #       puts "train is already at the beginning of the route"
  #     else
  #       @route.get_station(@current_station).train_departured(self)
  #       @current_station = prev_station
  #       @route.get_station(@current_station).train_arrived(self)
  #     end
  #   end
  #
  #   def show_current_station
  #     return puts "Train has no route" unless @route
  #     puts "Current station: #{@route.get_station(@current_station).name}"
  #   end
  #
  #   def show_next_station
  #     return puts "Train has no route" unless @route
  #     next_station = @route.get_station(@current_station + 1)
  #     puts "Next station: #{next_station.name}" if next_station
  #   end
  #
  #   def show_prev_station
  #     return puts "Train has no route" unless @route
  #     prev_station = @route.get_station(@current_station - 1)
  #     puts "Previous station: #{prev_station.name}" if prev_station
  #   end
end
