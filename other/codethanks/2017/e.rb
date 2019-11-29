ps = [1,10,100,1000,10000]

n = gets.chomp.to_i

ans = []
s = 0
while n > 0
  x = n >= 5 ? 5 : n
  n -= 5
  puts "? #{([0] * (s*5) + ps[0...x] + [0] * [n, 0].max).join " "}"
  $stdout.flush
  x = gets.chomp.to_i
  while x != 0
    case x%10
    when 8
      ans << 0
      x -= 8
    when 9
      ans << 1
      x -= 9
    when 0
      ans << 0
      x -= 10
    when 1
      ans << 1
      x -= 11
    when 2
      ans << 0
      x -= 12
    end
    x /= 10
  end
  s += 1
end

puts "! #{ans.join " "}"
$stdout.flush