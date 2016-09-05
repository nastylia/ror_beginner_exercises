require_relative 'train'
require_relative 'station'
require_relative 'acessors'
class Test
  include Acessors

  attr_accessor_with_history :a, :b
  strong_attr_acessor :c, String
end


t = Test.new
puts "t.a = #{t.a}"
puts "t.b = #{t.b}"
t.a = 10
puts "t.a = #{t.a}"
t.a = 16
puts "t.a = #{t.a}"
puts "history for t.a: #{t.a_history}"

t.b = 12
puts "t.b = #{t.b}"
t.b = 77
puts "t.b = #{t.b}"
puts "history for t.b: #{t.b_history}"

puts "test strong_accessor:"
puts "t.c = #{t.c}"
begin
  t.c = 22
rescue ArgumentError => e
  puts "!!!  Exception: #{e.message} !!!"
end
puts "t.c = #{t.c}"
t.c = "Hello"
puts "t.c = #{t.c}"



