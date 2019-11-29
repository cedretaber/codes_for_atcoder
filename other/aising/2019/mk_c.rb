puts "400 400"

400.times do |i|
  if i.odd?
    puts ".#" * 200
  else
    puts "#." * 200
  end
end