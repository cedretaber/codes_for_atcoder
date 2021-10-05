n = gets.to_i

(0...30).each do |k|
  x = 1
  (0...30).each do |i|
    x *= 3
    x += 1 if i == k
  end
  if x == n
    puts k + 1
    exit
  end
end

puts -1
