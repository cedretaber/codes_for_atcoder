x, y, a, b = gets.split.map(&:to_i)
e = 0
while x * (a-1) < b
  break if x*a >= y
  e += 1
  x *= a
end
puts e + (y-x-1)/b