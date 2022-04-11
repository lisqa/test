=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_accessor :train_comes, :train_leaves, :trains, :trains_by
    
  def initialize(station)
    @station = station
    @trains = []
  end

  def train_comes(train)
    @trains << train
  end

  def trains_by(type)
    train_type1 = []
    @trains.each do |train| 
      if type == train.type
        train_type1 << train 
      end
    end
    return train_type1.length    
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
  attr_accessor :route_stations, :current_station_index, 
  
  def initialize(first_station, end_station)    
    @route_stations = [first_station, end_station]
  end

  def add_station(station)
    @route_stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @route_stations[0] && station != @route_stations[-1]
      @route_stations.delete(station)
    end
  end

  def first
    @current_station_index = 0
    @route_stations[0]
  end

  def end
    @route_stations[-1]
  end

  def current
    @route_stations[@current_station_index]
  end

  def next
    if @route_stations[-1] != @route_stations[@current_station_index]
      @current_station_index += 1
    end
    @route_stations[@current_station_index]
  end

  def back
    if @current_station_index != 0
      @current_station_index -= 1
    end
    @route_stations[@current_station_index]
  end

  def next_station
    if @route_stations[-1] != @route_stations[@current_station_index]
      @route_stations[@current_station_index+1]
    end
  end

  def previos_station
    if @route_stations[0] != @route_stations[@current_station_index]
      @route_stations[@current_station_index-1]
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
  attr_accessor :go, :train_start
  attr_reader :speed, :wagons, :number, :type
  
  
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

  def train_start(route)
    route.first
  end

  def train_forward
    route.next
  end

  def train_back
    route.back
  end    

  def train_current_station
    route.current
  end

  def train_next_station
    route.next_station
  end

  def train_previos_station
    route.previos_station
  end
end
