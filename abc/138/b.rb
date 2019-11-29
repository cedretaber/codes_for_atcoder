n = gets.to_i
a = gets.split.map { |i| Rational(1, i.to_i) }.reduce(:+)
r = a.denominator.to_f / a.numerator.to_f
puts "%.10f" % r