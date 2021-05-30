puts 1
1.times do
  puts 500
  puts (1..500).to_a.shuffle.join(" ")
end
