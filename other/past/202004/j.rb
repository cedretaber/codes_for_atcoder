s = gets.chomp
while /\([^()]*\)/ =~ s
  s.gsub!(/\(([^()]*)\)/) { $1 + $1.reverse }
end
puts s