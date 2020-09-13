# frozen_string_literal: true

module Validator
  module Station
    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate!
      raise 'Name is missing' if name.empty?

      true
    end
  end

  module Train
    NUMBER_FORMAT = /^.{3}-*.{2}$/.freeze

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate!
      raise 'Number has invalid format' if number !~ NUMBER_FORMAT

      true
    end
  end

  module Route
    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate!
      stations.each do |station|
        raise 'Station is missing in route' if station.name.empty?
      end
      true
    end
  end

  module Carriage
    def valid?
      validate
    rescue StandardError
      false
    end

    private

    def validate!
      raise 'Number is missing' if number.empty?
    end
  end
end
