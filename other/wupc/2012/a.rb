m, d = gets.split.map(&:to_i)
t1 = Time.new(2012, m, d)
m, d = gets.split.map(&:to_i)
t2 = Time.new(2012, m, d)

puts ((t2 - t1) / (24 * 60 * 60)).to_i
