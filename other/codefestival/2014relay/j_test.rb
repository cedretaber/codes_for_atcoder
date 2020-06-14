def solve s, k, last=nil
  s.each.with_index do |c, i|
    next if c || (last && (last - i).abs <= k)
    t = s.dup
    t[i] = true
    return true unless solve(t, k, i)
  end
  false
end

1.upto(20) do |n|
  res = []
  0.upto(n) do |k|
    res << (solve([false] * n, k) ? "T" : "F")
  end
  puts res.join(" ")
end