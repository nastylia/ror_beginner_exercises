months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Ввведите день:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

# check year 
if (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
  months[1] += 1
end

result_days = day
while month > 1 do
  month -= 1
  result_days += months[month]
end

puts "Количество дней с начала года: #{result_days}"