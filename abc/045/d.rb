h, w, n = gets.split.map(&:to_i)
ps = Hash.new { 0 }
n.times do
  a, b = gets.split.map(&:to_i)
  (a-1..a+1).each do |i|
    (b-1..b+1).each do |j|
      ps["#{i}:#{j}"] += 1 if 1 < i && i < h && 1 < j && j < w
    end
  end
end

rs = Array.new(10) { 0 }
s = 0
ps.each do |_, n|
  s += 1
  rs[n] += 1
end
rs[0] = (h-2)*(w-2) - s

puts rs