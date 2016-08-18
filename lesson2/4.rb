alphabet = ("a".."z").to_a
vowels = ["a", "e", "i", "o", "u", "y"]
result = {}

alphabet.each_with_index do |letter, index|
  result[letter] = index + 1 if vowels.include? letter
end

puts "#{result}"