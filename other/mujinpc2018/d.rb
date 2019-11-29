
def check x, y
  last = []
  while (x != 0 && y != 0)
    if x < y
      x = x.to_s.reverse.to_i
    else
      y = y.to_s.reverse.to_i
    end
    if x < y
      y -= x
    else
      x -= y
    end
    p [x, y]
    return false if [x, y] == last
    last = [x, y]
  end
  true
end

n, m = gets.split.map(&:to_i)
check(n, m)

# (1..n).each do |x|
#   (1..m).each do |y|
#     puts "(#{x}, #{y}) ... #{check(x, y)}"
#   end
# end