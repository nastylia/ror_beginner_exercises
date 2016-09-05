module Validation

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def validate!
      rules = self.class.rules
      puts rules
      rules.each do |type, params|
        params.each { |name, arg| send(type, name, arg)}
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    protected

    def presence(name, args)
      var_to_check = get_instance_var_by_name(name)
      raise 'Name cannot be nil' if var_to_check.nil?
      raise 'Name cannot be empty' if var_to_check.empty?
    end

    def format(name, format)
      var_to_check = get_instance_var_by_name(name)
      raise 'Wrong format for train name!' if var_to_check !~ format
    end

    def type(name, attr_class)
      var_to_check = get_instance_var_by_name(name)
      raise "Wrong class/type. Should be #{attr_class}" unless attr_class.include? var_to_check
    end

    def get_instance_var_by_name(name)
      var_name = "@#{name.to_s}".to_sym
      instance_variable_get(var_name)
    end
  end

  module ClassMethods
    attr_accessor :rules

    def validate(name, type, args = "")
      self.rules ||= {}
      rules[type] = {name => args}
      puts "!!!!!!" + rules.to_s
    end
  end

end