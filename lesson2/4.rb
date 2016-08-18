alphabet = ("a".."z").to_a
vowels = ["a", "e", "i", "o", "u", "y"]
result = {}

for letter in alphabet do
  result[letter] = alphabet.index(letter) + 1 if vowels.include? letter
end

puts "#{result}"