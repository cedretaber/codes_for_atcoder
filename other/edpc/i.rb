n = gets.chomp.to_i
ps = gets.split.map(&:to_f)

memo = Array.new(n) { Array.new(n+1) }

(0...n).each do |i|
  if i.zero?
    memo[i][0] = 1 - ps[i]
    memo[i][1] = ps[i]
    next
  end
  (0..i+1).each do |j|
    memo[i][j] = (memo[i-1][j].nil? ? 0 : memo[i-1][j] * (1 - ps[i])) + (j.zero? ? 0 : memo[i-1][j-1] * ps[i])
  end
end

ret = 0
(n/2+1..n).each do |c|
  ret += memo[n-1][c]
end
puts ret