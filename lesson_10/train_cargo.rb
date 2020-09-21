# frozen_string_literal: true

require_relative 'train'

class TrainCargo < Train
  def add_carriage(carriage)
    super if carriage.is_a?(CarriageCargo)
  end
end
