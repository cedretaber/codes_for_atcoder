puts "1000 #{1000*1001/2}"
# puts Array.new(1000) { 0 }.join(" ")
puts Array.new(1000) { rand(0..10**9) }.join(" ")