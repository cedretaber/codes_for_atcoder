require "open3"

count = 0
loop do
  r = rand(1..300)
  g = rand(1..300)
  b = rand(1..300)

  d1in, d1out, _, _ = Open3.popen3('./d2')
  d2in, d2out, _, _ = Open3.popen3('./d3')

  input = "#{r} #{g} #{b}"
  d1in.puts input
  d2in.puts input
  out1 = d1out.gets.chomp
  out2 = d2out.gets.chomp
  if out1 != out2
    puts "Fail!"
    puts input
    exit!
  end

  count += 1
  puts "Count: #{count}" if count%100 == 0
end
