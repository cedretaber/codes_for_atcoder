puts 15

memo = {}

15.times do
  x = y = 0
  loop do
    x = rand(-10000..10000)
    y = rand(-10000..10000)
    break unless memo[[x,y]]
  end
  memo[[x,y]] = true
  puts "#{x} #{y} #{rand(1..1000000)}"
end