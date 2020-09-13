# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validator'

class Station
  include InstanceCounter
  include Validator::Station

  attr_reader :name
  attr_accessor :trains

  @@stations = []

  class << self
    def all
      @@stations
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instances
    validate!
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def return_trains(type)
    trains.each { |train| train if train.type == type }
  end

  def trains_in_station
    trains.each { |train| yield train }
  end
end
