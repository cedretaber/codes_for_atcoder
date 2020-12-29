s = gets.chomp
puts s.include?("xxx") ? "x" : s.include?("ooo") ? "o" : "draw"