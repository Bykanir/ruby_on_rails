require_relative 'company'

class Carriage
  include Company

	attr_reader :number, :type

	def initialize(number, type)
		@number = number
		@type = type
	end
end