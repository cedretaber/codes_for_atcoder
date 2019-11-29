n = gets.chomp.to_i

map = []
n.times do |i|
  map << gets.chomp.chars.map(&:ord)
end
rmap = map.transpose

cnt = 0

n.times do
  cnt += 1 if map == rmap
  map.rotate!
  rmap.map!(&:rotate!)
end

puts cnt * n