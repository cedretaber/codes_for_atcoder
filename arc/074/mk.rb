puts 10**5
puts ((10**5)*3).times.map { (rand(10**9) + 1).to_s }.join(" ")