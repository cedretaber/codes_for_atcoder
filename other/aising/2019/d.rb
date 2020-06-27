n, q = gets.split.map(&:to_i)
aa = gets.split.map(&:to_i)

q.times do
  x = gets.to_i
  as = aa.dup
  t = 0
  until as.empty?
    as.sort!
    t += as.pop
    d = 100
    as.each do |a|
      d = [d, (a - x).abs].min
    end
    i = 0
    as.each.with_index do |a, j|
      if (a - x).abs == d
        i = j
        break
      end
    end
    as.delete_at i
  end
  puts t
end