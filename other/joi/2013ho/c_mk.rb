puts "100000 100000 200000"
memo = {}
200000.times do
  p = nil
  p = [rand(1..100000), rand(1..100000)] while p.nil? || memo[p]
  memo[p] = true
  x, y = p
  puts "#{x} #{y}"
end