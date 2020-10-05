n = gets.to_i
s = gets.chomp.chars
rs = Array.new(100) { Regexp.new(s * ".{#{_1}}") }
puts Array.new(n) {
  t = gets.chomp
  rs.any? { _1 =~ t } ? 1 : 0
}.sum