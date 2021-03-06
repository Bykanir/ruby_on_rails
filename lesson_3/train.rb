require_relative 'requireable'

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
    @current_station = route.stations[0]
    current_station.add_train(self)
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
    route.stations[index_current_station + 1] if index_current_station < route.stations.size
  end

  def last_station
    route.stations[index_current_station - 1] if index_current_station > 0
  end

  private

  def move(station)
    current_station.send_train(self)
    current_station = station
    current_station.add_train(self) 
  end 
end