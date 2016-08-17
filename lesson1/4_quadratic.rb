puts "Введите три коэффициента квадратного уравнения (а, b, с):"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

discriminant = b ** 2 - 4 * a * c

if discriminant < 0
  puts "D < 0, Корней нет"
elsif discriminant == 0
  puts "D = 0, #{- b / (2 * a)}"
else
  x1 = (- b + Math.sqrt(discriminant)) / (2 * a)
  x2 = (- b - Math.sqrt(discriminant)) / (2 * a)
  puts "D > 0, #{x1}, #{x2}"
end