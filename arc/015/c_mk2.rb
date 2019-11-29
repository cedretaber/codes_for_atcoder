puts 200
n = "a"
200.times do |i|
  puts "#{n} #{i+2} #{n.succ}"
  n = n.succ.succ
end