
n = 3

arr = Array.new(n) { Array.new(n) { 0 } }

def p_arr arr
  puts arr.map { |line| line.join(" ") }.join("\n")
end

memo = {}

100000.times do |c|
  if memo[arr]
    puts "#{c} times"
    exit
  end
  memo[arr] = true
  arr = arr.map { |line| line.dup }
  p_arr arr
  x = y = 0
  while x < n && y < n
    if arr[y][x] == 0
      arr[y][x] = 1
      y += 1
    else
      arr[y][x] = 0
      x += 1
    end
  end
  puts "(#{x},#{y})"
end