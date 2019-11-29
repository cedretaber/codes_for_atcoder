puts "2000 2000"

2000.times do
  puts 2000.times.map { %w(. . . #).sample }.join("")
end