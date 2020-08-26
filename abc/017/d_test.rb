require "open3"

count = 0
loop do
  n = rand(1..20)
  m = rand(1..20)

  d1in, d1out, _, _ = Open3.popen3('./d')
  d2in, d2out, _, _ = Open3.popen3('./d2')

  input = ["#{n} #{m}"]
  d1in.puts input.last
  d2in.puts input.last
  n.times do
    input << rand(1..m).to_s
    d1in.puts input.last
    d2in.puts input.last
  end
  out1 = d1out.gets.chomp
  out2 = d2out.gets.chomp
  if out1 != out2
    puts "Fail!"
    puts input.join("\n")
    exit!
  end

  count += 1
  puts "Count: #{count}" if count%100 == 0
end