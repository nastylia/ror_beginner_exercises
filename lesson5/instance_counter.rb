module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    @@instance_objects = 0

    def instances
      puts "#{@@instance_objects}"
    end

    def increase
      @@instance_objects += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.increase
    end
  end

end