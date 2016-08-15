sides = Array.new(3)

puts "Ввведите 3 стороны треугольника:"
sides[0] = gets.chomp.to_f
sides[1] = gets.chomp.to_f
sides[2] = gets.chomp.to_f

sides.sort!
if sides[0]**2 + sides[1]**2 == sides[2]**2
	puts "Треугольник прямоугольный"
	if sides[0] == sides[1]
		puts "А также треугольник равнобедренный"
	end
else
	puts "Треугольник не прямоугольный"
end



#puts "#{sides}"
