# frozen_string_literal: true

require_relative 'company'
require_relative 'validator'

class Carriage
  include Company
  include Validator::Carriage

  attr_reader :number

  def initialize(number)
    @number = number
    validate!
  end
end
