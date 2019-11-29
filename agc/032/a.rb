n = gets.chomp.to_i
as = gets.split.map(&:to_i)

ns = as.reduce({}) { |h, a|
  if h[a]
    h[a] += 1
  else
    h[a] = 1
  end
  h
}

memo = {}

slv = ->i,xs {
  return memo[xs] if memo[xs]
  if i == n+1
    ys = []
    xs.each do |x| ys.insert(x-1, x) end
    memo[xs] =
      if ys == as
        xs
      else
        nil
      end
  else
    (1..i).each do |j|
      next if ns[j].nil? || ns[j].zero?
      ns[j] -= 1
      if r = slv.(i+1, xs.dup.insert(j-1, j))
        return memo[xs] = r
      end
      ns[j] += 1
    end
    memo[xs] = nil
  end
}

if r = slv.(1, [])
  puts r
else
  puts "-1"
end