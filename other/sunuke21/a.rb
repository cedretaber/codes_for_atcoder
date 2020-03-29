n = gets.to_i
l = 1
r = 10**9
while l+1 < r
  m = (l+r)/2
  if m * (m+1) / 2 <= n
    l = m
  else
    r = m
  end
end
if l * (l+1) / 2 == n
  puts l
else
  puts -1
end