puts "1000 300000 10000"
300000.times do
  puts "#{rand(1..1000)} #{rand(1..1000)} #{rand(1..1000000000)}"
end
# 300000.times do |i|
#   puts "#{1} #{2} #{i + 1}"
# end