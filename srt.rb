=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station

  attr_accessor :train_comes, :train_leaves
  
  def initialize(station)
    @station = station
    @freight = []
    @passenger = []
  end

  def train_comes(type, number)
    if type == "freight"
      @freight << number
    else
      @passenger << number
    end
  end

  def list_of_trains
    fre = @freight.length
    pass = @passenger.length
    return {"freight" => fre, "passenger" => pass}
  end

  def train_leaves(type, number)
    if type == "freight"
      @freight.delete(number)
    else
      @passenger.delete(number)
    end
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

  attr_accessor :add_station, :remove_station
  attr_reader :inner_stations, :route

  def initialize(first_station, end_station, inner_stations = [])    
    @first_station = first_station
    @end_station = end_station
    @inner_stations = inner_stations
  end

  def route
    @route = [@first_station, @end_station].insert(1, @inner_stations).flatten
  end

  def add_station(station_n)
    @inner_stations << station_n
  end

  def remove_station(station_n)
    @inner_stations.delete(station_n)
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

  attr_accessor :go, :start, :forward, :i, :back
  attr_reader :speed, :wagons, :train_station
  attr_writer :route
  
  def initialize(number, type, wagons)
    @number = number.to_s 
    @type = type
    @wagons = wagons.to_i 
    @start = {}
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
    @wagons -= 1 if @speed == 0
  end

  def start(number, route)
    @i = 0
    @start = {number => route.route[@i]}
  end

  def forward(number, route)
    @i += 1
    @start = {number => route.route[@i]}
  end

  def back(number, route)
    @i -= 1
    @start = {number => route.route[@i]}
  end    

  def train_station(number, route)
    next_st = route.route[@i+1]
    previos_st = route.route[@i-1]
    current_st = route.route[@i]
    return {"previos station" => previos_st, "current station" => current_st, "next station" => next_st}
  end
  
end
