require_relative 'instance_counter'

class Station
  include InstanceCounter

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
end