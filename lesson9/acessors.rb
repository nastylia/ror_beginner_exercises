module Acessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name, var_name_get, var_name_set, history_name, history_get =
          ["@#{name}", name, "#{name}=", "@#{name}_values", "#{name}_history"].map(&:to_sym)

        define_method(var_name_get) do
          instance_variable_get(var_name)
        end

        define_method(history_get) do
          instance_variable_get(history_name) || []
        end

        define_method(var_name_set) do |value|
          instance_variable_set(history_name, send(history_get) << value)
          instance_variable_set(var_name, value)
        end
      end
    end

    def strong_attr_acessor(attr_name, attr_class)
      var_name, var_name_set, var_name_get =
        ["@#{attr_name}", "#{attr_name}=", attr_name].map(&:to_sym)

      define_method(var_name_get) do
        instance_variable_get(var_name)
      end

      define_method(var_name_set) do |value|
        raise ArgumentError, "#{value} should be #{attr_class} class" unless value.is_a? attr_class
        instance_variable_set(var_name, value)
      end
    end
  end
end
