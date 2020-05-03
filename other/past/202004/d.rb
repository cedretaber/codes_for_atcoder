s = gets.chomp;
a = [*?a..?z, ?., ""]
r = 0
memo = {}
a.each do |x|
  a.each do |y|
    a.each do |z|
      reg = /#{x}#{y}#{z}/
      unless memo[reg]
        memo[reg] = true
        r += 1 if reg =~ s
      end
    end
  end
end
puts r-1