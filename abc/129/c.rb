
p = 10**9+7

n, m = gets.split.map(&:to_i)

ss = Array.new(n*2) { 0 }
bs = Array.new(n*2) { false }

m.times do
  a = gets.chomp.to_i
  bs[a] = true
end

ss[0] = 1

n.times do |i|
  next if bs[i]
  ss[i+1] = (ss[i+1] + ss[i]) % p
  ss[i+2] = (ss[i+2] + ss[i]) % p
end

puts ss[n]