# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  attr_reader :name
  attr_accessor :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
    register_instances
    valid?(first_station, :presence)
  end

  def add_station(station)
    stations.insert(1, station)
  end

  def delete_station(station)
    stations.delete(station) if station != @first_station && station != @last_station
  end
end
