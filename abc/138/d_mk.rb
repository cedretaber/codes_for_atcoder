puts "#{10**5*2} #{10**5*2}"
(10**5*2-1).times do |i|
  puts "#{i+1} #{i+2}"
end
(10**5*2).times do
  puts "#{rand(1..10**5*2)} #{rand(1..10**4)}"
end
# (10**5*2-1).times do |i|
#   p = rand(1..i+1)
#   puts "#{p} #{i+2}"
# end
# (10**5*2).times do
#   puts "#{rand(1..10**5*2)} #{rand(1..10**4)}"
# end