arr =[0, 1]

sum = 1

while sum < 100 do
  arr << sum
  sum = arr[-1] + arr[-2]
end

puts "#{arr}"