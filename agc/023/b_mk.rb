FLG = true

puts 300
300.times do
  puts 300.times.map { FLG ? ?a : [*?a..?z].sample }.join
end