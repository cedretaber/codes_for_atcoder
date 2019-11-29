def solve n
  min_n = 1.0/0
  i = 0
  last = nil
  loop do
    i += 1
    s = n * i
    nm = s.to_s.chars.map(&:to_i).sum
    if nm < min_n
      min_n = nm
      last = i
    end
    break if min_n <= 1 * (s.to_s.length + 1)
  end
  [min_n, last]
end

2.upto(100) do |n|
  min, last = solve(n)
  puts "#{n} * #{last} = #{n*last}, #{min}"
end