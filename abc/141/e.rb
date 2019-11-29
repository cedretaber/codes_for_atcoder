n = gets.chomp.to_i
s = gets.chomp

min_l = 0
max_l = n/2+1

while min_l+1 < max_l
  l = (min_l + max_l) / 2
  memo = {}
  ok = false
  0.upto(n-l) do |i|
    k = s[i...i+l]
    if memo[k]
      if memo[k]+l-1 < i
        ok = true
        break
      end
    else
      memo[k] = i
    end
  end
  if ok
    min_l = l
  else
    max_l = l
  end
end

puts min_l