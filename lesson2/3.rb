arr =[]
arr << 0
arr << 1

i = 0
while arr[i] + arr[i+1] <= 100 do
  arr << arr[i] + arr[i+1]
  i += 1
end

puts "#{arr}"