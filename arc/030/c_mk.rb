puts  "300 299 1"
puts Array.new(300) { "a" }.join(" ")
(1..299).each do |i|
  puts "#{i} #{i+1}"
end