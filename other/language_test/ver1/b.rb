x = gets.chomp
puts gets.chomp.split(//).reject { |c| c == x }.join
