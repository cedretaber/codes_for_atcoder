def rstr
  3.times.map { [*?a..?z].sample }.join
end

puts "#{rstr} #{rstr}"
puts 1000
1000.times do
  puts rstr
end