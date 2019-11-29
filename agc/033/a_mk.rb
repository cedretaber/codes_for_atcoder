puts "1000 1000"

1000.times do
  puts 1000.times.map { ".........#".chars.sample }.join
end