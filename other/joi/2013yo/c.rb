n = gets.to_i
s = gets.chomp.chars
rs = Array.new(100) { |i| Regexp.new(s.join ".{#{i}}") }
puts Array.new(n) {
  t = gets.chomp
  rs.any? { |r| r =~ t } ? 1 : 0
}.sum