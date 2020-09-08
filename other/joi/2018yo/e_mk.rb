puts "30 30"
puts Array.new(30) { Array.new(30) { rand(1..10000) }.join(" ") }.join("\n")