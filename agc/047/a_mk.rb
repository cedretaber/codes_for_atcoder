puts 200000
puts Array.new(200000) { "#{rand(0..10000)}.#{rand(0..100000000)}" }.join(?\n)