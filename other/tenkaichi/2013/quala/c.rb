DS = [[1,1,0], [1,0,1], [2,2,0], [2,0,2], [3,3,0], [3,0,3]]

def solve n, m
  @arr = Array.new(n) { Array.new(m) }
  @n = n
  @m = m
  def impl i, j
    n1 = n2 = n3 = true
    DS.each do |x, di, dj|
      ii = i-di
      jj = j-dj
      next if ii < 0 || ii >= @n || jj < 0 || jj >= @m
      n1 = false if x == 1 && @arr[ii][jj] == 1
      n2 = false if x <= 2 && @arr[ii][jj] == 2
      n3 = false if x <= 3 && @arr[ii][jj] == 3
    end

    return [n1, n2, n3].count(true) if i == @n-1 && j == @m-1

    n = i*@m + j + 1
    ii = n / @m
    jj = n % @m
    r = 0
    if n1
      @arr[i][j] = 1
      r += impl ii, jj
    end
    if n2
      @arr[i][j] = 2
      r += impl ii, jj
    end
    if n3
      @arr[i][j] = 3
      r += impl ii, jj
    end
    r
  end
  impl 0, 0
end

puts (1..20).map { |i|
  (1..20).map { |j|
    "%3d" % solve(i, j)
  }.join(" ")
}.join(?\n)