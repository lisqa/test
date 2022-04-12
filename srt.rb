=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :trains, :station
    
  def initialize(station)
    @station = station
    @trains = []
  end

  def train_comes(train)
    @trains << train
  end

  def trains_by(type)
    @trains.select {|train| type == train.type}    
  end

  def count_trains_by(type)
    self.trains_by(type).length    
  end

  def train_leaves(train)
    @trains.delete(train)
  end
end

=begin 
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. 
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_accessor :route_stations
  
  def initialize(first_station, end_station)
    @route_stations = [first_station, end_station]
  end

  def add_station(station)
    @route_stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @first_station && station != @end_station
      @route_stations.delete(station)
    end
  end
end

=begin 
Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, 
эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). 
Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route). 
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
  attr_accessor :speed, :wagons, :number, :type
  attr_writer :train_route #может принимать маршрут следования

  def initialize(number, type, wagons)
    @number = number.to_s 
    @type = type
    @wagons = wagons.to_i 
  end

  def go(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagons
    @wagons += 1 if @speed == 0
  end

  def remove_wagons
    @wagons -= 1 if @speed == 0 && @wagons >= 1
  end

  def train_route(route) #перемещает поезд на первую станцию в маршруте
    route.route_stations[0].train_comes(self) 
  end

  def next_station(route, station) #возвращает следующую станцию в маршруте
    route.route_stations[route.route_stations.index(station)+1] 
  end

  def back_station(route, station) 
    route.route_stations[route.route_stations.index(station)-1] if route.route_stations.index(station) > 0
  end

  def go_next_from(route, station) #перемещает поезд на следующую станцию в маршруте
    route.route_stations[route.route_stations.index(station)+1].train_comes(self)
  end

  def go_back_from(route, station)
    route.route_stations[route.route_stations.index(station)-1].train_comes(self) if route.route_stations.index(station) > 0
  end

  def current_station(route) #определяет текущую станцию
    route.route_stations.select { |station| station if station.trains.include?(self) }
  end
end 
