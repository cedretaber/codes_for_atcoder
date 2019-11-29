N = 500

def nums
  ss = [*'0'..'9']
  (1..9).map { ss.sample }.join.to_i
end

puts "#{N} #{nums} #{nums}"
puts (1..N).map { nums.to_s }.join(" ")