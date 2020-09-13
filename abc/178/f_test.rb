require "open3"

count = 0
loop do
  count += 1
  puts "Count: #{count}" if count%100 == 0
  n = rand(10..100)
  as = Array.new(n) { rand(1..n) }.sort
  bs = Array.new(n) { rand(1..n) }.sort
  Open3.popen3('./f') do |din, dout, _, _|
    din.puts n
    din.puts as.join(" ")
    din.puts bs.join(" ")
    out = dout.gets.chomp
    next if out == "No"
    p out
    out = dout.gets.split.map(&:to_i)
    p out
    as.zip(out).each do |a, b|
      if a == b
        puts "Error!"
        puts "AS: #{as.join(" ")}"
        puts "BS: #{bs.join(" ")}"
        puts "Result: #{out.join(" ")}"
        exit 1
      end
    end
  end
end