c_map = (?a..?z).map.with_index { |c, i| [c, i] }.to_h

s1, s2, s3 = Array.new(3) { gets.chomp.chars.map { |c| c_map[c] } }
cs = [*s1, *s2, *s3].uniq
cl = cs.length

if cl > 10
  puts "UNSOLVABLE"
  exit
end

z1, z2, z3 = [s1, s2, s3].map(&:first)
l1, l2, l3 = [s1, s2, s3].map(&:length)
max_l = [l1, l2, l3].max
cc = Array.new(26)
[*0..9].permutation(cs.length) do |ns|
  i = 0
  while i < cl
    cc[cs[i]] = ns[i]
    i += 1
  end
  
  next if cc[z1] == 0
  next if cc[z2] == 0
  next if cc[z3] == 0

  x = y = z = i = 0
  while i < max_l
    x = x * 10 + cc[s1[i]] if i < l1
    y = y * 10 + cc[s2[i]] if i < l2
    z = z * 10 + cc[s3[i]] if i < l3
    i += 1
  end
  if x + y == z
    puts x, y, z
    exit
  end
end

puts "UNSOLVABLE"
