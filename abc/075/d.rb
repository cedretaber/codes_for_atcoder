$stdin.read.split(?\n).map { |line| line.split(?\s).map(&:to_i) }.tap do |(n, k), *ls|
  ps = []
  xs = []
  ys = []
  ls.each do |x, y|
    ps << [x, y]
    xs << x
    ys << y
  end
  xs.sort!
  ys.sort!

  ss = Array.new(n+1) { Array.new(n+1) { 0 } }

  n.times do |i|
    n.times do |j|
      ss[j+1][i+1] = ps.select { |x, y| x <= xs[i] && y <= ys[j] }.length
    end
  end

  min_size = 1.0/0
  0.upto(n-1) do |xi|
    xi.upto(n-1) do |xj|
      0.upto(n-1) do |yi|
        yi.upto(n-1) do |yj|
          if (ss[yj+1][xj+1] - ss[yi][xj+1] - ss[yj+1][xi] + ss[yi][xi] >= k)
            size = (xs[xj] - xs[xi]) * (ys[yj] - ys[yi])
            min_size = min_size < size ? min_size : size
          end
        end
      end
    end
  end
  puts min_size
end