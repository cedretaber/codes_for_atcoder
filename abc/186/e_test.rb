def solve n, s, k
  return -1 if s % n.gcd(k) != 0

  r = 0
  until s.zero?
    r += 1
    s += k
    s %= n
  end
  r
end

require "open3"

count = 0
loop do
  count += 1
  puts "count: #{count}" if count % 100 == 0

  din, dout, _, _ = Open3.popen3('./e')
  
  n = rand(2..100)
  s = rand(1...n)
  k = rand(1..100)

  din.puts "1"
  din.puts "#{n} #{s} #{k}"
  din.close
  res = dout.read.chomp

  exp = solve n, s, k
  if res != exp.to_s
    puts "Fail!"
    puts "N=#{n} S=#{s} K=#{k}"
    puts "Expected: #{exp}, but: #{res}."
    exit 1
  end
end