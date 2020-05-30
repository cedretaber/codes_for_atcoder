x = 10**5

puts x
d = 1
arr = [0]
x.times do
  d *= 2
  a = [d - 10**8, 0].max
  arr << a
  d = [(d/2-a)*2, 10**8].min
end
puts arr.join(" ")