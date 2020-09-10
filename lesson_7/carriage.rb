require_relative 'company'
require_relative 'validator'

class Carriage
  include Company
  include Validator::Carriage

  attr_reader :number, :type
  
  def initialize(number, type)
    @number = number
    @type = type
    validate!
  end
end