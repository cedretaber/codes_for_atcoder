puts "1000 1000"

ns = [*1..1000**2].shuffle
puts 1000.times.map { 1000.times.map { x = ns.first; ns = ns[1..-1]; x }.join(" ") }.join("\n")