puts "#{10**5*2} #{rand(1..(10**5*2 * (10**5*2-1) / 2))}"
puts Array.new(10**5*2) { rand(-(10**9)..10**9) }.join(" ")
