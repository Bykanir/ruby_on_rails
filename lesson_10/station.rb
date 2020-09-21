# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  extend Validation::ClassMethods
  include Validation::InstanceMethods

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
    valid?(name, :type, String)
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
