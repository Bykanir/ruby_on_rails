# frozen_string_literal: true

require_relative 'carriage'

class CarriageCargo < Carriage
  attr_accessor :available_volume, :occupied_volume

  def initialize(number, volume)
    super(number)
    @available_volume = volume
    @occupied_volume = 0
  end

  def carriage_filing(volume)
    self.occupied_volume += volume
    self.available_volume -= volume
  end
end
