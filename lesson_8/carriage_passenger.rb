require_relative 'carriage'

class CarriagePassenger < Carriage

  attr_accessor :free_seats, :occupied_seats

  def initialize(number, seats)
    super(number)
    @free_seats = seats
    @occupied_seats = 0
  end

  def took_seat
    self.occupied_seats += 1
    self.free_seats -= 1
  end
end
