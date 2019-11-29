
DP = Array.new(101) { {} }

readlines.tap do |nw, *rest|
  N, W = nw.split.map(&:to_i)
  ws, vs = rest.map { |line| line.split.map(&:to_i) }.transpose

  solve = ->i, v {
    DP[i][v] =
      case
      when DP[i][v]
        DP[i][v]
      when i == N
        0
      when v < ws[i]
        solve.(i+1, v)
      else
        [solve.(i+1, v), solve.(i+1, v - ws[i]) + vs[i]].max
      end
  }

  puts solve.(0, W)
end