puts "Ваше имя?"
name = gets.chomp.capitalize!

puts "Ваш рост?"
height = gets.chomp.to_i

ideal_weight = height - 110

if ideal_weight >= 0
  puts "#{name}, ваш идеальный вес #{ideal_weight}"
else
  puts "Ваш вес уже оптимальный"
end