n = gets.to_i

map = Array.new(n) { gets.chomp }

cnt = 0
0.upto((1<<n)-1) do |top|
  arr = Array.new(n) { Array.new(n) { 0 } }
  0.upto(n-1) do |i|
    arr[0][i] = top[i]
  end
  0.upto(n-2) do |i|
    0.upto(n-1) do |j|
      x = 0
      x += arr[i-1][j] if i > 0
      x += arr[i][j-1] if j > 0
      x += arr[i][j+1] if j < n-1
      arr[i+1][j] = 1 if (map[i][j] == "." && x.odd?) || (map[i][j] == "#" && x.even?)
    end
  end
  if (0...n).all? { |j|
    x = arr[n-2][j]
    x += arr[n-1][j-1] if j > 0
    x += arr[n-1][j+1] if j < n-1
    (map[n-1][j] == "." && x.even?) || (map[n-1][j] == "#" && x.odd?)
  }
    p arr
    cnt += 1
  end
end

p cnt