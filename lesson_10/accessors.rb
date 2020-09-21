module Accessors
  def attr_accessor_with_history(*args)
    args.each do |attr|
      attr_name = "@#{attr}".to_sym
      history = []
      define_method(attr) { instance_variable_get(attr_name) }

      define_method("#{attr}=".to_sym) do |value| 
        history << value
        instance_variable_set(attr_name, value)
     end

      define_method("#{attr}_history".to_sym) { history }
    end
  end

  def strong_attr_accessor(attr, attr_class)
    attr_name = "@#{attr}".to_sym
    define_method(attr) { instance_variable_get(attr_name) }

    define_method("#{attr}=".to_sym) do |value| 
      raise unless attr_name.is_a?(attr_class)
      instance_variable_set(attr_name, value) 
    end
  end
end