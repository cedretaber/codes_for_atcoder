es = []
700.times do |i|
  (i+1...700).each do |j|
    if rand > 0.5
      es << "#{i+1} #{j+1}"
    end
  end
end

puts "700 #{es.length}"
es.each do |e| puts e end 