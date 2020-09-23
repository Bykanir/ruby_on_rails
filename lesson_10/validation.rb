module Validation
  module ClassMethods

    attr_reader :validators

    def validate(attr_name, type_validation, add_parametr = true)
      @validators = []
      @validators << [attr_name, type_validation, add_parametr]
    end
  end
  
  module InstanceMethods
    def valid?
      validate!
    rescue 
      false
    end

    def validate!
      self.class.validators.each do |validator|
        attr_name = instance_variable_get("@#{validator[0]}")
        type_validation = validator[1]
        add_parametr = validator[2]
        send(type_validation, attr_name, add_parametr)
      end
    end

    private

    def presence(attr, options = true)
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
end