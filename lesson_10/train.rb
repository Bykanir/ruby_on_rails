# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Company
  include InstanceCounter
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  validate :number, :format, /^.{3}-*.{2}$/

  attr_reader :route, :number, :carriages, :index_current_station

  @@trains = []

  class << self
    def find(number)
      @@trains.detect { |train| train.number == number }
    end
  end

  def initialize(number)
    @number = number
    @carriages = []
    @speed = 0
    @@trains << self
    register_instances
    validate!
  end

  def stop
    speed = 0
  end

  def add_carriage(carriage)
    carriages << carriage if speed.zero?
  end

  def delete_carriage(carriage)
    carriages.delete(carriage) if speed.zero?
  end

  def accept_route(route)
    @route = route
    @current_station = route.stations[0]
    current_station.add_train(self)
    @index_current_station = 0
  end

  def move_forward
    move(next_station)
    self.index_current_station += 1
  end

  def move_backward
    move(last_station)
    self.index_current_station -= 1
  end

  def next_station
    route.stations[index_current_station + 1] if index_current_station < route.stations.size
  end

  def last_station
    route.stations[index_current_station - 1] if index_current_station.positive?
  end

  def carriages_train
    carriages.each { |carriage| yield carriage }
  end

  private

  attr_accessor :speed, :current_station
  attr_writer :index_current_station

  def move(station)
    current_station.send_train(self)
    current_station = station
    current_station.add_train(self)
  end
end
