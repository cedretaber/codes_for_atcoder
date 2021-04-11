n = gets.to_i
cs = gets.split.map(&:to_i)
t = Array.new(n) { [] }
(n - 1).times do
  a, b = gets.split.map { |n| n.to_i - 1 }
  t[a] << b
  t[b] << a
end

memo = Array.new(10**5 + 1) { false }
res = []

solve = ->(i, p) {
  f = false
  if !memo[cs[i]]
    res << i + 1
    f = true
  end
  memo[cs[i]] = true
  t[i].each do |j|
    solve.(j, i) if j != p
  end
  memo[cs[i]] = false if f
}
solve.(0, -1)
puts res.sort * ?\n
