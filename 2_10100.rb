=begin 
Заполнить массив числами от 10 до 100 с шагом 5
=end

arr = []
for i in 10..100
  arr << i if i % 5 == 0
end
