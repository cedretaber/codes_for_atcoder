n = (10**5)*2
c = 1

# puts "#{n} #{n}"
# puts Array.new(n) { rand(1..c) }.join(" ")
# n.times do
#   q = rand(1..2)
#   if q == 1
#     puts "#{q} #{rand(1..n)} #{rand(1..n)}"
#   else
#     puts "#{q} #{rand(1..n)} #{rand(1..c)}"
#   end
# end
qs = []
(1..10**5-1).each do |i|
  qs << "1 #{i} #{i+1}"
end
(10**5+1..10**5*2-1).each do |i|
  qs << "1 #{i} #{i+1}"
end
qs << "1 #{10**5} #{10**5+1}"

(10**5).times do
  qs << "2 #{rand(1..n)} #{rand(1..n)}"
end

puts "#{n} #{qs.length}"
puts (1..n).to_a.join(" ")
puts qs.join(?\n)