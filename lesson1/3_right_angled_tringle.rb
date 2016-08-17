sides = []

puts "Ввведите 3 стороны треугольника:"
sides << gets.chomp.to_f
sides << gets.chomp.to_f
sides << gets.chomp.to_f

sides.sort!
if sides[0]**2 + sides[1]**2 == sides[2]**2
  puts "Треугольник прямоугольный"
else
  puts "Треугольник не прямоугольный"
end

if sides[0] == sides[1]
  puts "А также треугольник равнобедренный"
end



#puts "#{sides}"
