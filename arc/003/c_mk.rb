puts "500 500"
arr = Array.new(500) { Array.new(500) { rand(1..9) } }
arr[0][0] = 's'
arr[499][499] = 'g'
puts arr.map { |line| line.join }.join(?\n)