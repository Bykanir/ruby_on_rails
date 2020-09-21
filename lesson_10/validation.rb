module Validation
  module ClassMethods
    def validate(attr_name, type_validation, add_parametr)
      presence(attr_name) if type_validation == :presence
      format(attr_name, add_parametr) if type_validation == :format
      type(attr_name, add_parametr) if type_validation == :type
    end

    private

    def presence(attr)
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
      validate!(attr_name, type_validation, add_parametr)
    end
    
    private

    def validate!(attr_name, type_validation, add_parametr)
      self.class.validate(attr_name, type_validation, add_parametr)
    end
  end
end