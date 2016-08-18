products = {}

loop do
  puts "Название товара (или 'stop'):"
  name = gets.chomp
  break if name == "stop"

  puts "Цена за единицу товара:"
  price = gets.chomp.to_f

  puts "Количество купленного товара:"
  number = gets.chomp.to_f

  products[name] = {price => number}
end

sum = 0;
puts "Все товары:"
products.each do |product, v|
  v.each do |price, number|
    sum += price * number;
    puts "Название - #{product}, цена - #{price}, количество - #{number}.    Итого: #{price * number}"
  end
end

puts "Итоговая сумма всех покупок: #{sum}"