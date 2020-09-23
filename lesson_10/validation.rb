module Validation
  module ClassMethods

    attr_reader :validators

    def validate(attr_name, type_validation, add_parametr = nil)
      @validators = [attr_name, type_validation, add_parametr]
    end

    private

    def presence(attr, nil)
      raise 'Name is wrong' if attr.empty? || attr.nil?

      true
    end

    def format(attr, expression)
      raise 'Format is wrong' if attr !~ expression

      true
      end

    def type(attr, attr_class)
      raise 'Class is wrong' if attr.class != attr_class

      true
    end
  end
  
  module InstanceMethods
    def valid?(attr_name, type_validation, add_parametr = nil)
      self.class.validate(attr_name, type_validation, add_parametr)
      validate!
      true
    rescue 
     puts 'Что-то пошло не так'
      false
    end
    
    private

    def validate!
      type_validation = self.class.validators[1].to_sym
      self.class.send(type_validation, self.class.validators[0], self.class.validators[2])
    end
  end
end

class Test
  extend Validation::ClassMethods
  include Validation::InstanceMethods

  def initialize(name)
    @name = name
    valid?(name, 'presence')
  end
end