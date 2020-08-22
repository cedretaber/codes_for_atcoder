puts 2000
arr = [42] * 3 + [99] * 12 + [810] * 15 + Array.new(6000-3-12-15) { rand(1..2000) }
puts arr.shuffle.join(" ")