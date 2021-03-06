puts 2 * 10**5
(2 * 10**5).times do |i|
  puts 1
  puts "#{i + 1}"
  puts 1
  puts "#{2 * 10**5 + i + 1}"
end
