require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

class Main

  def initialize
    @stations = {}
    @trains = {}
  end


  def menu

    loop do
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. Добавить вагон к поезду"
      puts "4. Отцепить вагон от поезда"
      puts "5. Поместить поезд на станцию"
      puts "6. Просмотреть списoк станций и список поездов на станции"
      puts "7. Вывести список вагонов у поезда"
      puts "8. Вывести список поездов на станции"
      puts "9. Занять место или объем в вагоне"
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
      when 7
        list_carriages_for_train
      when 8
        list_trains_on_station
      when 9
        occupy_seat_or_volume
      when 0
        break
      else
        puts "Выберите пункт из меню"
      end
    end

  end

  # все методы, кроме меню, спрятала в privateб чтобы управление из вне класса шло только через
  # меню... то же касается атрибутов на чтение. Решила что они только внутренние и никому больше
  # не нужен к ним доступ
  private

  attr_reader :stations, :trains

  def create_station
    puts "Имя новой станции?"
    station_name = gets.chomp
    @stations[station_name] = Station.new(station_name)
    list_all_stations
  end

  def create_train
    begin
      puts "Имя нового поезда?"
      train_name = gets.chomp
      puts "Тип поезда? (cargo или passenger)"
      train_type = gets.chomp

      if cargo_type? train_type
        @trains[train_name] = CargoTrain.new(train_name)
      else
        @trains[train_name] = PassengerTrain.new(train_name)
      end
      puts "Поезд #{train_name} был создан успешно"
    rescue RuntimeError => e
      puts "Введите правильные данные для нового поезда: #{e.message}"
      retry
    end

    list_all_trains
  end

  def add_carriage_to_train
    train = ask_for_train_from_list("Выберите поезд из списка, к которому добавить вагон:")
    return puts "Нет такого поезда" unless train
    
    puts "Укажите тип вагона, который будете добавлять: (cargo или passenger)"
    carriage_type = gets.chomp
    if cargo_type? carriage_type
      puts "Укажите общий объем вагона:"
      volume = gets.chomp.to_f
      train.add_carriage(CargoCarriage.new(volume))
    else
      puts "Укажите количество мест в вагоне:"
      seats_number = gets.chomp.to_i
      train.add_carriage(PassengerCarriage.new(seats_number))
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

    train.move_to_station(station)
    #station.train_arrived(train)
  end

  def list_stations_and_trains_on_them
    stations.each {|name, station| station.list_trains_on_station}
  end

  def list_carriages_for_train
    train = ask_for_train_from_list("Выберите поезд из списка:")
    return puts "Нет такого поезда" unless train

    train.get_carriages do |carriages|
      carriages.each do |number, carriage|
        puts "Номер вагона: #{number}, #{carriage.to_s}"
      end
    end
  end

  def list_trains_on_station
    station = ask_for_station_from_list("Выберите станцию из списка:")
    return puts "Нет такой станции" unless station

    station.get_trains {|train| puts train}
  end

  def occupy_seat_or_volume
    train = ask_for_train_from_list("Выберите поезд из списка:")
    return puts "Нет такого поезда" unless train

    carriage = ask_for_carriage_from_list("Выберите вагон из списка:", train)
    return puts "Нет такого вагона" unless carriage

    if carriage.cargo_type?
      puts "Какой объем занять?"
      volume = gets.chomp.to_f
      carriage.take_volume(volume)
    else
      carriage.take_a_seat
    end

  end







  def cargo_type?(type)
    type.to_sym == :cargo
  end

  def list_all_stations
    puts "Список всех станций:"
    print_list_by_name(stations.keys)
  end

  def list_all_trains
    puts "Список всех поездов:"
    print_list_by_name(trains.keys)
  end

  def print_list_by_name(arr)
    arr.each { |name| puts "#{name}"}
  end

  def ask_for_item_from_list(message, hash_to_search)
    puts "#{message}"
    print_list_by_name(hash_to_search.keys)
    item_name = gets.chomp

    item = hash_to_search[item_name]
  end

  def ask_for_train_from_list(message)
    ask_for_item_from_list(message, trains)
  end

  def ask_for_station_from_list(message)
    ask_for_item_from_list(message, stations)
  end

  def ask_for_carriage_from_list(message, train)
    train.get_carriages do |carriages|
      ask_for_item_from_list(message, carriages)
    end
  end
end
