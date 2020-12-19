puts 100
100.times do
  n = rand(2..10**9)
  s = rand(1...n)
  k = rand(1..10**9)
  puts "#{n} #{s} #{k}"
end