puts 2**18
(2**18).times do
  puts "#{rand(1..10**5)} #{rand(1..10**3)}"
end
puts 10**5
(10**5).times do
  puts "#{rand(2**9...2**18)} #{rand(10**4..10**5)}"
end