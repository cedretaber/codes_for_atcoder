h = {}
h["a"] = gets.chomp
h["b"] = gets.chomp
h["c"] = gets.chomp

t = "a"
while !h[t].empty?
  nt = h[t][0]
  h[t] = h[t][1..-1]
  t = nt
end

puts t.upcase