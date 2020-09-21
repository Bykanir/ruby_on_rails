# frozen_string_literal: true

require_relative 'company'
require_relative 'validation'

class Carriage
  include Company
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  attr_reader :number

  def initialize(number)
    @number = number
    valid?(number, :format, /^.{3}$/)
  end
end
