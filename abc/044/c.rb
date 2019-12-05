$stdin.read.split.map(&:to_i).tap do |n, a, *xs|
  dp = Array.new(n) { Array.new(n+1) { Array.new(n*50+1) } }
  s = ->i, c, v {
    if i == n
      c != 0 && v%c == 0 && v/c == a ? 1 : 0
    else
      dp[i][c][v] ||= (s.(i+1, c, v) + s.(i+1, c+1, v+xs[i]))
    end
  }
  puts s.(0, 0, 0)
end
