n = gets.chomp.to_i

bs = n.times.map { gets.split.map(&:to_i) }

r = 100
n.times do |i|
  n.times do |j|
    next if i == j
    x = bs[i][0] - bs[j][0]
    y = bs[i][1] - bs[j][1]
    next if x == 0 && y == 0
    bh = bs.reduce({}) { |h, b| h[b] = true; h }
    rr = 0
    n.times do |k|
      next unless bh[bs[k]]
      rr += 1
      t = bs[k]
      bh[t] = false
      while bh[[t[0]+x, t[1]+y]]
        t = [t[0]+x, t[1]+y]
        bh[t] = false
      end
      t = bs[k]
      while bh[[t[0]-x, t[1]-y]]
        t = [t[0]-x, t[1]-y]
        bh[t] = false
      end
    end
    r = r < rr ? r : rr
  end
end
r = 1 if n == 1

puts r