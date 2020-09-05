class Station

  attr_reader :name
  attr_accessor :trains     

  def initialize(name)
    @name = name
    @trains = []
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