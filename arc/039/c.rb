O = 505
D = { "L" => [-1, 0], "R" => [1, 0], "U" => [0, 1], "D" => [0, -1] }

k = gets.to_i
arr = Array.new(O*2) { Array.new(O*2) { false } }
arr[O][O] = true

x = O
y = O

i = 0
gets.chomp.chars.each do |s|
  puts "#{i}: #{x-O} #{y-O}"
  i += 1
  d = D[s]
  x += d[0]
  y += d[1]
  while arr[y][x]
    x += d[0]
    y += d[1]
  end
  arr[y][x] = true
end

puts "#{x-O} #{y-O}"