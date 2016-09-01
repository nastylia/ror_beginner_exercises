module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance_objects

    def instances
      self.instance_objects ||= 0
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instance_objects = self.class.instances + 1
    end
  end
end
