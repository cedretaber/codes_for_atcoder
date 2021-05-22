a, b, k = gets.split.map(&:to_i)

@cs = Array.new(31) { Array.new(31) { 1 } }
(1..30).each do |a|
  (1..30).each do |b|
    @cs[a][b] = ((b + 1)..(b + a)).reduce(:*) / (1..a).reduce(:*) 
  end
end

@res = []
def solve a, b, k
  if k == 0
    a.times do @res << 'a' end
    b.times do @res << 'b' end
    return
  end

  d = @cs[a - 1][b]
  if k >= d
    @res << 'b'
    solve(a, b - 1, k - d)
  else
    @res << 'a'
    solve(a - 1, b, k)
  end
end
solve(a, b, k - 1)
puts @res.join
