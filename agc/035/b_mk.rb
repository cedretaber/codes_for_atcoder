puts "#{10**5} #{10**5}"
memo = {}
(10**5).times do
  ab = nil
  loop do
    ab = rand(1..10**5), rand(1..10**5)
    next if memo[ab]
    memo[ab] = true
    break
  end
  puts "#{ab[0]} #{ab[1]}"
end