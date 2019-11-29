nm = 10**5
puts "#{nm} #{nm}"

d = (10**9*2)/10**5
nums = (-10**9).step(10**9, d).to_a[1..-1].map(&:to_s)
line = nums.join " "
puts line
puts line