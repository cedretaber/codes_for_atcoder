n, k = gets.split.map(&:to_i)
ps = []
ms = []
zc = 0

gets.split.each do |n|
  n = n.to_i
  if n > 0
    ps << n
  elsif n < 0
    ms << -n
  else
    zc += 1
  end
end

ps.sort!
ms.sort!

m_len = ps.length * ms.length
z_len = zc * (n-zc) + zc * (zc-1) / 2

if k <= m_len
  l = -(10**18-1)
  r = 0
  ms.reverse!
  while l+1 < r
    m = (l+r)/2
    kk = 0
    ps.each do |p|
      ll = 0
      rr = ms.length
      next if p * -ms[0] > m
      while ll+1 < rr
        mm = (ll+rr)/2
        if p * -ms[mm] <= m
          ll = mm
        else
          rr = mm
        end
      end
      kk += rr
    end
    if kk < k
      l = m
    else
      r = m
    end
  end
  puts r
elsif k <= m_len + z_len
  puts 0
else
  k -= m_len + z_len
  l = 0
  r = 10**18+1
  while l+1 < r
    m = (l+r)/2
    kk = 0
    ps[0..-2].each.with_index do |p, i|
      ll = i+1
      rr = ps.length
      next if p * ps[i+1] > m
      while ll+1 < rr
        mm = (ll+rr)/2
        if p * ps[mm] <= m
          ll = mm
        else
          rr = mm
        end
      end
      kk += ll-i
    end
    ms[0..-2].each.with_index do |p, i|
      ll = i+1
      rr = ms.length
      next if p * ms[i+1] > m
      while ll+1 < rr
        mm = (ll+rr)/2
        if p * ms[mm] <= m
          ll = mm
        else
          rr = mm
        end
      end
      kk += ll-i
    end
    if kk < k
      l = m
    else
      r = m
    end
  end
  puts r
end