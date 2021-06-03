puts "448 100000"
100000.times do
  i = j = 0
  while i == j
    i = rand(1..448)
    j = rand(1..448)
  end
  puts "#{i} #{j}"
end
