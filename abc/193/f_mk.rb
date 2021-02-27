puts 100
100.times do
  puts Array.new(100) { ["W", "B", "?"].sample }.join
end
