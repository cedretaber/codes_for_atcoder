puts "30 1000"
puts Array.new(1000) { "#{rand(1..(2**30))} #{rand(1..(2**30))} #{%w(J O I).sample}" }.join(?\n)