months = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

puts "Ввведите день:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

# check year 
if year % 400 == 0
  months[2] += 1
elsif year % 4 == 0 && year % 100 != 0
  months[2] += 1
end

result_days = day
loop do  
  month -= 1
  break if month == 0
  result_days += months[month]
end

puts "Количество дней с начала года: #{result_days}"