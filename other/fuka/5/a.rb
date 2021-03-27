lines = STDIN.read.split(?\n)
loop do
  n, k = lines.shift.split.map(&:to_i)
  break if n.zero?
  puts lines.shift.split.map(&:to_i).sort.take(k).sum
end
