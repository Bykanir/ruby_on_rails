# frozen_string_literal: true

require_relative 'train'

class TrainPassenger < Train
  def add_carriage(carriage)
    super if carriage.is_a?(CarriagePassenger)
  end
end
