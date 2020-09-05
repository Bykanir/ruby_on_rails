require_relative 'requireable'

class App

	attr_reader :stations, :trains, :routes, :carriages

	def initialize
    @stations = []
    @trains = []
    @routes = []
    @carriages = []
  end

  def create_station
    puts 'Enter station name'
    stations << Station.new(gets.chomp)
  end

  def create_train
    puts 'Which type train'
    puts '1 - Passenger'
    puts '2 - Cargo'
    type_train = gets.chomp.to_i

    puts 'Which number train'
    trains << train_types[type_train - 1].new(gets.chomp)
  end

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

  private

  #Это все вспомогательные методы, чтобы не "раздувать" основные методы

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
    return carriages << CarriageCargo.new(number) if type == 1
    return carriages << CarriagePassenger.new(number) if type == 2
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
end