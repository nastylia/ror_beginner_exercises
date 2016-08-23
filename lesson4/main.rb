require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

class Main

  def initialize
    @stations = []
    @trains = []
  end


  def menu

    loop do
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. Добавить вагон к поезду"
      puts "4. Отцепить вагон от поезда"
      puts "5. Поместить поезд на станцию"
      puts "6. Просмотреть списoк станций и список поездов на станции"
      puts "0. Выйти из меню"

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
      when 0
        break
      else
        puts "Выберите пункт из меню"
      end
    end

  end


  private

  attr_reader :stations, :trains

  def create_station
    puts "Имя новой станции?"
    station_name = gets.chomp
    @stations << Station.new(station_name)
    list_all_stations
  end

  def create_train
    puts "Имя нового поезда?"
    train_name = gets.chomp
    puts "Тип поезда? (cargo или passenger)"
    train_type = gets.chomp

    if cargo_type? train_type
      @trains << CargoTrain.new(train_name)
    else
      @trains << PassengerTrain.new(train_name)
    end

    list_all_trains
  end

  def add_carriage_to_train
    train = ask_for_train_from_list("Выберите поезд из списка, к которому добавить вагон:")
    return puts "Нет такого поезда" unless train
    
    puts "Укажите тип вагона, который будете добавлять: (cargo или passenger)"
    carriage_type = gets.chomp
    if cargo_type? carriage_type
      train.add_carriage(CargoCarriage.new)
    else
      train.add_carriage(PassengerCarriage.new)
    end
    train.carriage_number

  end

  def delete_carriage_from_train
    train = ask_for_train_from_list("Выберите поезд из списка, у которого удалить вагон:")
    return puts "Нет такого поезда" unless train

    train.delete_carriage
    train.carriage_number
  end

  def add_train_to_station
    train = ask_for_train_from_list("Выберите поезд из списка, который поместить на станцию:")
    return puts "Нет такого поезда" unless train

    station = ask_for_station_from_list("Выберите станцию из списка, куда поместить поезд")
    return puts "Нет такой станции" unless station

    station.train_arrived(train)
  end

  def list_stations_and_trains_on_them
    stations.each {|station| station.list_trains_on_station}
  end







  def cargo_type?(type)
    type == "cargo"
  end

  def list_all_stations
    puts "Список всех станций:"
    print_list_by_name(stations)
  end

  def list_all_trains
    puts "Список всех поездов:"
    print_list_by_name(trains)
  end

  def print_list_by_name(arr)
    arr.each { |item| puts "#{item.name}"}
  end

  def get_item_by_name(item_name, list_to_search)
    i = 0
    list_to_search.each_with_index { |item, index| i = index if item.name == item_name}
    list_to_search[i]
  end

  def ask_for_item_from_list(message, list_to_search)
    puts "#{message}"
    print_list_by_name(list_to_search)
    item_name = gets.chomp

    item = get_item_by_name(item_name, list_to_search)
  end

  def ask_for_train_from_list(message)
    ask_for_item_from_list(message, trains)
  end

  def ask_for_station_from_list(message)
    ask_for_item_from_list(message, stations)
  end
end
