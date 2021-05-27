require "open3"

cnt = 0
loop do
  cnt += 1
  puts "Count: #{cnt}" if cnt % 100 == 0

  rin, rout, _, _ = Open3.popen3("python3 ./b.py")
  din, dout, _, _ = Open3.popen3("./b")

  h = w = 10
  bb = Array.new(h) { Array.new(w) { rand(0..9) } }

  rin.puts "#{h} #{w}"
  din.puts "#{h} #{w}"
  bb.each do |l|
    rin.puts l.join
    din.puts l.join
  end

  rans = rout.read
  dans = dout.read
  if rans != dans
    puts "Fail! Python: #{rans}, D: #{dans}"
    bb.each do |l| puts l.join end
    exit 1
  end
end
