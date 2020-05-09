puts 10**6
puts [
  "D" * (10**6/3),
  "M" * (10**6/3),
  "C" * ((10**6) - (10**6/3)*2)
].join
puts 75
puts (0...75).to_a.reverse.map { |i| 10**6 - i }.join(" ")