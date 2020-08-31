class Train

  attr_accessor :speed, :carriages, :current_station, :index_current_station
  attr_reader :route

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = 0
    @speed = 0
  end

  def stop
    speed = 0
  end

  def add_carriage
    carriages += 1 if speed == 0
  end

  def delete_carriage
    carriages -= 1 if speed == 0
  end

  def accept_route(route)
    @route = route
    @current_stations = route.stations[0]
    current_stations.add_train(self)
    @index_current_station = 0
  end

  def move_forward
    move(next_station)
    index_current_station += 1
  end

  def move_backward
    move(last_station)
    index_current_station -= 1
  end

  def next_station
    route.stations[index_current_station + 1]
  end

  def last_station
    route.stations[index_current_station - 1]
  end

  private

  def move(station)
    current_stations.send_train(self)
    current_stations = station
    current_stations.add_train(self)   
  end 
end