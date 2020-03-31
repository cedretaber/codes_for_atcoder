DS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
d = Object.new 

def d.next x, y
  @i ||= 0
  dx, dy = DS[@i]
  [x + dx, y + dy]
end

def d.rrote!
  @i ||= 0
  @i = (@i + 1) % 4
  self
end

def d.lrote!
  @i ||= 0
  @i -= 1
  @i = 3 if @i < 0
  self
end

cood = Array.new(1001) { Array.new(1001) { 0 } }
x = y = 500

res = []
1000.times do
  ox, oy = x, y
  if cood[y][x].even?
    d.rrote!
  else
    d.lrote!
  end
  x, y = d.next x, y
  res << cood[y][x] % 2
  cood[oy][ox] += 1
end

# puts cood.reverse.map(&:join) * ?\n
p res.join
