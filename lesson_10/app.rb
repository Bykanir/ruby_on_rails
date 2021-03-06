# frozen_string_literal: true

require_relative 'requireable'

# rubocop:disable Metrics/ClassLength
class App
  attr_reader :stations, :trains, :routes, :carriages

  def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  # rubocop:disable Metrics/MethodLength, Metrics/BlockLength, Metrics/AbcSize, Metrics/CyclomaticComplexity
  def start
    loop do
      puts 'Hello!'
      puts 'Enter command'
      puts '1 - Create Station'
      puts '2 - Create train'
      puts '3 - Create route'
      puts '4 - Add station in route'
      puts '5 - Delete station in route'
      puts '6 - Destination train route'
      puts '7 - Create carriage'
      puts '8 - Hook or unhook carriage'
      puts '9 - Train movement in stations'
      puts '10 - View list stations and trains at the station'
      puts '11 - Display info about trains at all stations'
      puts '12 - Display info about carriages'
      puts '13 - Load the carriage or take seat'
      puts '0 - Exit from the program'

      command = gets.chomp

      case command
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_route
      when '4'
        add_station
      when '5'
        delete_station
      when '6'
        assign_route
      when '7'
        create_carriage
      when '8'
        shunting_works
      when '9'
        move_train
      when '10'
        stations_and_trains
      when '11'
        trains_in_station
      when '12'
        carriages_train
      when '13'
        load_or_take_carriage
      when '0'
        puts 'Good Bay!'
        break
      end
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/BlockLength, Metrics/AbcSize, Metrics/CyclomaticComplexity

  private

  def create_station
    puts 'Enter station name'
    stations << Station.new(gets.chomp)
  end

  # rubocop:disable Metrics/AbcSize
  def create_train
    puts 'Which type train'
    puts '1 - Passenger'
    puts '2 - Cargo'
    type_train = gets.chomp.to_i

    puts 'Which number train'
    trains << train_types[type_train - 1].new(gets.chomp)
  rescue StandardError
    puts '<You have entered the wrong train number format. Repeat creation!>'
    retry
  end
  # rubocop:enable Metrics/AbcSize

  def create_route
    list_stations(message_first_station: true)
    first_station = station_search(gets.chomp.to_i)

    list_stations(message_last_station: true)
    last_station = station_search(gets.chomp.to_i)

    routes << Route.new(first_station, last_station)
  end

  def add_station
    list_routes(message_list_routes: true)
    route = route_search(gets.chomp.to_i)

    list_stations(message_list_stations: true)
    route.add_station(station_search(gets.chomp.to_i))
  end

  def delete_station
    list_routes(message_list_routes: true)
    route = route_search(gets.chomp.to_i)

    list_stations(message_list_stations: true)
    route.delete_station(station_search(gets.chomp.to_i))
  end

  def assign_route
    list_trains(message_list_trains: true)
    train = train_search(gets.chomp.to_i)

    list_routes(message_list_routes: true)
    train.accept_route(route_search(gets.chomp.to_i))
  end

  def create_carriage
    puts 'Which type carriage'
    puts '1 - Passenger'
    puts '2 - Cargo'
    type = gets.chomp.to_i

    puts 'Which number carriage'
    types_carriage(gets.chomp, type)
  end

  def move_train
    list_trains(message_list_trains: true)
    train = train_search(gets.chomp.to_i)

    move(train)
  end

  def shunting_works
    list_trains(message_list_trains: true)
    shunting(train_search(gets.chomp.to_i))
  end

  def stations_and_trains
    puts '1 - Station list'
    puts '2 - Station trains list'
    list_stations_and_trains(gets.chomp.to_i)
  end

  def train_types
    [TrainPassenger, TrainCargo]
  end

  def list_stations(message_list_stations: false, message_first_station: false, message_last_station: false)
    puts 'Enter number the first station of the route' if message_first_station
    puts 'Enter number the last station of the route' if message_last_station
    puts 'List stations' if message_list_stations
    stations.each.with_index(1) do |station, index|
      puts "#{index}: #{station.name}"
    end
  end

  def station_search(station_enter)
    stations[station_enter - 1]
  end

  def list_trains(message_list_trains: false)
    puts 'List trains' if message_list_trains
    trains.each.with_index(1) do |train, index|
      puts "#{index}: #{train.number}"
    end
  end

  def train_search(train)
    trains[train - 1]
  end

  def list_routes(message_list_routes: false)
    puts 'List routes' if message_list_routes
    routes.each.with_index(1) do |route, index|
      puts "#{index}: #{route.name}"
    end
  end

  def route_search(route)
    routes[route - 1]
  end

  def types_carriage(number, type)
    case type
    when 1
      puts 'Indicate the number of passenger seats'
      carriages << CarriagePassenger.new(number, gets.chomp.to_i)
    when 2
      puts 'Indicate cargo volume'
      carriages << CarriageCargo.new(number, gets.chomp.to_i)
    end
  end

  def move(train)
    puts 'Where are we going?'
    puts '1 - Forward'
    puts '2 - Backward'
    choice = gets.chomp.to_i
    return train.move_forward if choice == 1
    return train.move_backward if choice == 2
  end

  def list_stations_and_trains(choice)
    return list_stations(message_list_stations: true) if choice == 1
    return list_station_trains if choice == 2
  end

  def list_station_trains
    list_stations(message_list_stations: true)
    station = station_search(gets.chomp.to_i)

    station.trains.each do |train, index|
      puts "#{index}: #{train.number}"
    end
  end

  def shunting(train)
    puts 'Add or disconnect?'
    puts '1 - Add'
    puts '2 - Disconnect'
    choice = gets.chomp.to_i

    return add_carriage(train) if choice == 1
    return delete_carriage(train) if choice == 2
  end

  def add_carriage(train)
    list_carriages(message_add: true)
    train.add_carriage(carriage_search(gets.chomp.to_i))
  end

  def delete_carriage(train)
    list_carriages(message_disconnect: true)
    train.delete_carriage(carriage_search(gets.chomp.to_i))
  end

  def list_carriages(message_list_carriages: false, message_add: false, message_disconnect: false)
    puts 'List carriages' if message_list_carriages
    puts 'Which carriage to add?' if message_add
    puts 'Which carriage to disconnect?' if message_disconnect
    carriages.each.with_index(1) do |carriage, index|
      puts "#{index}: #{carriage.number}"
    end
  end

  def carriage_search(carriage)
    carriages[carriage - 1]
  end

  def trains_in_station
    stations.each do |station|
      station.trains_in_station do |train|
        puts "Station #{station.name}
        Number train #{train.number},
        type #{train.class},
        carriages #{train.carriages.size}"
      end
    end
  end

  def carriages_train
    list_trains(message_list_trains: true)
    info_carriages_train(train_search(gets.chomp.to_i))
  end

  def info_carriages_train(train)
    train.carriages_train do |carriage|
      case carriage.class.to_s
      when 'CarriagePassenger'
        info_passenger_carriage(carriage)
      when 'CarriageCargo'
        info_cargo_carriage(carriage)
      end
    end
  end

  def info_passenger_carriage(carriage)
    puts "Number carriage #{carriage.number},
    free seats #{carriage.free_seats},
    occupied #{carriage.occupied_seats}"
  end

  def info_cargo_carriage(carriage)
    puts "Number carriage #{carriage.number},
    available volume #{carriage.available_volume},
    occupied #{carriage.occupied_volume}"
  end

  def load_or_take_carriage
    list_carriages(message_add: true)
    carriage = carriage_search(gets.chomp.to_i)
    load_or_take(carriage)
  end

  def load_or_take(carriage)
    case carriage.class.to_s
    when 'CarriageCargo'
      puts "Enter cargo volume. Free - #{carriage.available_volume}"
      carriage.carriage_filing(gets.chomp.to_i)
    when 'CarriagePassenger'
      carriage.took_seat
      puts "1 st place. Free #{carriage.free_seats}"
    end
  end
end
# rubocop:enable Metrics/ClassLength
