a = c = 0
b = d = 1
m1 = []
m2 = []
(2 ** 32).times do |i|
  if i % (10**6) == 0
    m1 << [a, b]
    m2 << [c, d]
  end
  a, b = b, (a**2 + b**2) % 1999
  c, d = d, (c**2 + d**2) % (10**9+7)
end

p m1
p m2
