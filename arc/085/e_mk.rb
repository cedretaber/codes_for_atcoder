puts 100
puts 100.times.map { [1, -1].sample * [*0..10000].sample }.join(" ")