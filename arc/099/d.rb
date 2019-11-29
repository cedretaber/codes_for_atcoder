nums = []
1.upto(10000000) do |i|
  s = i.to_s.chars.reduce(0) { |a, s| a + s.to_i }.to_f
  nums << i / s
end

nums.each.with_index(1) do |n, i|
  puts i if nums[i..-1].all? { |x| x >= n }
end