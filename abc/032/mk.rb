n, wr, vr =
  case ARGV[0]
  when "2"
    [200, (1..1000), (1..10**9)]
  when "3"
    [200, (1..10**9), (1..1000)]
  else
    [30, (1..10**9), (1..10**9)]
  end

puts "#{n} #{rand(1..10**9)}"
n.times do
  puts "#{rand(vr)} #{rand(wr)}"
end