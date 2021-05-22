ss = gets.split
n = gets.to_i
ts = Array.new(n) { /^#{gets.chomp.tr('*', '.')}$/ }
puts ss.map { |s| ts.any? { |t| t =~ s } ? ("*" * s.length) : s }.join(" ")
