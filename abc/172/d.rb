x = gets.to_i
r = 0
1.upto(x) do |i|
  d = x/i
  r += (d+1)*d/2*i
end
puts r