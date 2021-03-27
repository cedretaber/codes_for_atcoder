require "time"

loop do
  t = gets.chomp
  break if t == "0"

  t = Time.parse t
  s = gets.chomp.to_i(2)
  t += s
  puts t.strftime "%Y/%m/%d %H:%M:%S"
end
