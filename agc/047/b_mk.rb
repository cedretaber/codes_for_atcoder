puts 200000
s = "aaaaa"
(200000 - 4).times do
  puts s.reverse
  s.succ!
end
puts "a"
puts "aa"
puts "aaa"
puts "aaaa"
