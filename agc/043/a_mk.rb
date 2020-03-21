puts "10 10"
puts Array.new(10) { Array.new(10) { %w(. #).sample }.join }.join(?\n)