require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'validation'

# rubocop:disable Metrics/ClassLength
class Main
  MENU_ITEMS = [
    '1. Create station', '2. Create train', '3. Add carriage to train',
    '4. Delete carriage from train', '5. Move train to station',
    '6. List stations and trains on them', '7. List train\'s carriages',
    '8. List trains on station',
    '9. Take a seat or occupy volume in a carriage', '0. Exit'
  ].freeze

  def initialize
    @stations = {}
    @trains = {}
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  def menu
    loop do
      MENU_ITEMS.each { |item| puts item }

      menu_item = gets.chomp.to_i

      case menu_item
      when 1
        create_station
      when 2
        create_train
      when 3
        add_carriage_to_train
      when 4
        delete_carriage_from_train
      when 5
        add_train_to_station
      when 6
        list_stations_and_trains_on_them
      when 7
        list_carriages_for_train
      when 8
        list_trains_on_station
      when 9
        occupy_seat_or_volume
      when 0
        break
      else
        puts 'Select menu number'
      end
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity

  private

  attr_reader :stations, :trains

  def create_station
    puts 'Name for new station?'
    station_name = gets.chomp
    @stations[station_name] = Station.new(station_name)
    list_all_stations
  end

  def create_train
    puts 'Name for new train?'
    train_name = gets.chomp
    puts 'Train type? (cargo или passenger)'
    train_type = gets.chomp

    @trains[train_name] = create_train_by_type(train_name, train_type)

  rescue RuntimeError => e
    puts "Enter correct data for a train: #{e.message}"
    retry
  end

  def add_carriage_to_train
    train = ask_for_train_from_list('Select a train:')
    return puts 'No such train' unless train

    train.add_carriage(create_carriage_by_type(train))
  end

  def delete_carriage_from_train
    train = ask_for_train_from_list('Select a train:')
    return puts 'No such train' unless train

    train.delete_carriage
    train.carriage_number
  end

  def add_train_to_station
    train = ask_for_train_from_list('Select train to put to the station:')
    return puts 'No such train' unless train

    station = ask_for_station_from_list('Select the station:')
    return puts 'No such station' unless station

    train.move_to_station(station)
    # station.train_arrived(train)
  end

  def list_stations_and_trains_on_them
    stations.each { |_name, station| station.list_trains_on_station }
  end

  def list_carriages_for_train
    train = ask_for_train_from_list('Select the train from list:')
    return puts 'No such train' unless train

    train.carriages do |carriages|
      carriages.each do |number, carriage|
        puts "Carriage number: #{number}, #{carriage}"
      end
    end
  end

  def list_trains_on_station
    station = ask_for_station_from_list('Select station:')
    return puts 'No such station' unless station

    station.trains { |train| puts train }
  end

  def occupy_seat_or_volume
    train = ask_for_train_from_list('Select a train:')
    return puts 'No such train' unless train

    carriage = ask_for_carriage_from_list('Select carriage:', train)
    return puts 'No such carriage' unless carriage

    if carriage.cargo_type?
      puts 'Enter volume to occupy:'
      carriage.take_volume(gets.chomp.to_f)
    else
      carriage.take_a_seat
    end
  end

  def cargo_type?(type)
    type.to_sym == :cargo
  end

  def list_all_stations
    puts 'Stations\' list:'
    print_list_by_name(stations.keys)
  end

  def list_all_trains
    puts 'Trains\' list:'
    print_list_by_name(trains.keys)
  end

  def print_list_by_name(arr)
    arr.each { |name| puts name.to_s }
  end

  def ask_for_item_from_list(message, hash_to_search)
    puts message.to_s
    print_list_by_name(hash_to_search.keys)
    item_name = gets.chomp

    hash_to_search[item_name]
  end

  def ask_for_train_from_list(message)
    ask_for_item_from_list(message, trains)
  end

  def ask_for_station_from_list(message)
    ask_for_item_from_list(message, stations)
  end

  def ask_for_carriage_from_list(message, train)
    ask_for_item_from_list(message, train.carriages)
  end

  def create_train_by_type(name, type)
    if cargo_type?(type)
      CargoTrain.new(name)
    else
      PassengerTrain.new(name)
    end
  end

  def create_carriage_by_type(train)
    if train.cargo_type?
      puts 'Enter overall volume for cargo carriage:'
      CargoCarriage.new(gets.chomp.to_f)
    else
      puts 'Enter number of seats in the train:'
      PassengerCarriage.new(gets.chomp.to_i)
    end
  end
end
