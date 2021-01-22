# es = []
# 700.times do |i|
#   (i+1...700).each do |j|
#     if rand > 0.5
#       es << "#{i+1} #{j+1}"
#     end
#   end
# end

# puts "700 #{es.length}"
# es.each do |e| puts e end 

ns = (1..700).to_a.shuffle
x = rand(1..698)
as, bs = ns[0...x], ns[x..-1]

es = []
700.times do |i|
  i += 1
  xs = as.include?(i) ? as : bs
  xs.each do |x|
    es << "#{i} #{x}" if x > i
  end
end

puts "700 #{es.length}"
puts es.join(?\n)