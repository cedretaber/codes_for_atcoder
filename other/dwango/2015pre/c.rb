pt = Array.new(101) { Array.new(101) }
pt[0][0] = 1.0
1.upto(100) do |i|
  pt[i][0] = 1.0
  pt[i][i] = 1.0
  1.upto(i-1) do |j|
    pt[i][j] = pt[i-1][j-1] + pt[i-1][j]
  end
end

dp = Array.new(101)
dp[0] = 0
dp[1] = 0
dp[2] = 1.5

3.upto(100) do |n|
  r = 0.0
  d = 0.0
  0.upto(n) do |aa|
    0.upto(n-aa) do |bb|
      a = aa
      b = bb
      c = n - a - b
      a, b = b, a if a > b
      b, c = c, b if b > c
      a, b = b, a if a > b
      if (a == 0 && b == 0) || (a == b && b == c)
        d += pt[n][a] * pt[n-a][b] / 3**n
      else
        x = a == 0 ? b : a
        r += pt[n][a] * pt[n-a][b] / 3**n * dp[x]
      end
    end
  end
  dp[n] = (r + 1) / (1 - d)
end

n = gets.to_i
puts "%.12f" % dp[n]