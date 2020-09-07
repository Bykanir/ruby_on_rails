require_relative 'train'

class TrainPassenger < Train

  def add_carriage(carriage)
    super if carriage.type == :passenger
  end
end	