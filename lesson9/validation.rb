module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :rules

    def validate(name, type, args = '')
      self.rules ||= []
      rule = { type => { name: name, args: args } }
      rules << rule
    end
  end

  module InstanceMethods
    def validate!
      rules = self.class.rules
      rules.each do |rule|
        rule.each do |type, params|
          var_to_check = get_instance_var_by_name(params[:name])
          send(type, var_to_check, params[:args])
        end
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    protected

    def presence(var_to_check, _args)
      raise 'Name cannot be nil' if var_to_check.nil?
      raise 'Name cannot be empty' if var_to_check.empty?
    end

    def format(var_to_check, format)
      raise 'Wrong format for train name!' if var_to_check !~ format
    end

    def type(var_to_check, attr_class)
      raise "Wrong class/type. Should be #{attr_class}" unless attr_class.include? var_to_check
    end

    def get_instance_var_by_name(name)
      var_name = "@#{name}".to_sym
      instance_variable_get(var_name)
    end
  end
end
