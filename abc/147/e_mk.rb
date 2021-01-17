puts "80 80"
(80 * 2).times do
  puts Array.new(80) { rand(0..80) }.join(" ")
end