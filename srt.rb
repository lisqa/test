=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_accessor :train_comes, :train_leaves, :trains
    
  def initialize(station)
    @station = station
    @trains = []
  end

  def train_comes(number, type)
    @trains << [number, type]
  end

  def trains_type
    freight = 0
    @trains.each { |n, t| freight += 1 if t == "freight" }
    return {"freight" => freight, "passenger" => (@trains.length - freight) }
  end

  def train_leaves(number, type)
    @trains.delete([number, type])
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
  attr_accessor :add_station, :remove_station, :route_stations
  
  def initialize(first_station, end_station, *inner_stations)    
    @route_stations = [first_station, *inner_stations, end_station]
  end

  def add_station(station)
    @route_stations.insert(-2, station)
  end

  def remove_station(station)
    @route_stations.delete(station)
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
  attr_accessor :go, :current_station_index, :train, :train_start, :route
  attr_reader :speed, :wagons
  
  
  def initialize(number, type, wagons)
    @number = number.to_s 
    @type = type
    @wagons = wagons.to_i 
    @train = [@number, @type, @wagons]
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

  def train_start(route)
    @route = route.route_stations
    @current_station_index = 0
    { @train => @route[@current_station_index] }
  end

  def train_forward
    @current_station_index += 1
    { @train => @route[@current_station_index] }
  end

  def train_back
    @current_station_index -= 1
    { @train => @route[@current_station_index] }
  end    

  def train_current_station
    @route[@current_station_index]
  end

  def train_next_station
    @route[@current_station_index+1]
  end

  def train_previos_station
    @route[@current_station_index-1]
  end
end
