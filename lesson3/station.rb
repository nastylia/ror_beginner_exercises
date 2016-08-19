class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrived(train)
    @trains << train
    puts "Прибыл поезд #{train.id} на станцию #{name}"
  end

  def train_departured(train)
    puts "Поезд отправлен #{train.id} со станции #{name}" if @trains.delete(train)
  end

  def to_s
    print "#{name}, trains: "
    @trains.each {|t| print "#{t.to_s}, "}
    puts ""
  end


end