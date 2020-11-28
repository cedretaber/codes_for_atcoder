n = gets.to_i

l = 0
r = 10**18
while l+1 < r
  m = (l+r)/2
  if m * (m+1) / 2 <= n+1
    l = m
  else
    r = m
  end
end

puts n - l + 1