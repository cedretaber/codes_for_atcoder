include Math

a, b, x = gets.split.map(&:to_f)

min_r = 0.0
max_r = 90.0
1000.times do
  r = (min_r + max_r) / 2
  t = r * PI / 180.0
  y =
    if sin(t)*b > cos(t)*a
      (a*b - a*a/(2*tan(t))) * a
    else
      (tan(t)*b*b/2) * a
    end

  if x <= y
    max_r = r
  else
    min_r = r
  end
end

puts("%2.010f" % (90 - max_r))