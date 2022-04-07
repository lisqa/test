=begin 
Сумма покупок. Пользователь вводит поочередно название товара, 
цену за единицу и кол-во купленного товара (может быть нецелым числом). 
Пользователь может ввести произвольное кол-во товаров до тех пор, 
пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, 
а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. 
Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

cart = Hash.new 
productprice = Hash.new
product_price = 0

loop do 
  puts "Введите название товара, его цену и количество: "
  product = gets.chomp
  if product != "стоп"
    cost = gets.chomp.to_f
    quantity = gets.chomp.to_f
    cartprice = Hash.new
    cartprice[cost] = quantity
    cart[product] = cartprice
    product_price = cost * quantity
    productprice[product] = product_price
  else 
    break
  end
end

price = 0
productprice.each_value { |i| price += i }

puts "Товар - (цена - количество): #{cart}"
puts "Товар - итоговая сумма: #{productprice}"
puts "Итоговая сумма: #{price}"
