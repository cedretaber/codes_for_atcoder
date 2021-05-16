n = gets.to_i
b = 0
r = Float::INFINITY
while 2**b <= n
  x = 2**b
  a = n / x
  c = n % x
  r = [r, a + b + c].min
  b += 1
end
puts r
