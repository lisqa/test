=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :trains, :station_name
    
  def initialize(station)
    @station_name = station
    @trains = []
  end

  def station_index(route)
    route.list_of_stations.index(self)
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
  attr_accessor :list_of_stations
  
  def initialize(first_station, end_station)
    @list_of_stations = [first_station, end_station]
  end

  def add_station(station)
    @list_of_stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @list_of_stations[0] && station != @list_of_stations[-1]
      @list_of_stations.delete(station)
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
  attr_accessor :speed, :wagons, :number, :type, :train_route, :train_station

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

  def train_route(route)
    @train_route = route 
    @train_station = @train_route.list_of_stations[0]
  end

  def station_number(station) #индекс станции
    station.station_index(@train_route)
  end

  def current_station #текущая станция
    @train_route.list_of_stations[station_number(@train_station)] 
  end

  def go_next #перемещает на следующую станцию
    if @train_station != @train_route.list_of_stations[-1] #проверка не конечная ли станция?
       @train_station = self.next_station     #текущая станция меняется на следующую станцию
    else 
      @train_station = self.current_station
    end
  end

  def go_back
    if station_number(@train_station) > 0
      @train_station = self.back_station
    else 
      @train_station = self.current_station
    end
  end

  def next_station #возвращает следующую станцию в маршруте
    @train_route.list_of_stations[station_number(@train_station)+1] if @train_station != @train_route.list_of_stations[-1]
  end

  def back_station
    @train_route.list_of_stations[station_number(@train_station)-1] if station_number(@train_station) > 0
  end  
end 
