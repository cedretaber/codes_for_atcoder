res = []
0.upto(9) do |yy|
  y_base = 450 * yy
  0.upto(9) do |xx|
    x_base = 22 * xx
    0.upto(9) do |i|
      res << "#{x_base + i} #{y_base + i}"
    end
  end
end

puts res.length
res.each do |p| puts p end