k, s = gets.chomp.split(?\s).map(&:to_i)
puts [*0..k].repeated_permutation(3).select { |x, y, z| x + y + z == s }.length
