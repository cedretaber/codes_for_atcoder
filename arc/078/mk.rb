puts 10**5
puts [*1..10**5].each_cons(2).map { |a, b| "#{a} #{b}" }.to_a