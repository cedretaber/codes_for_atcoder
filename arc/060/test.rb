def f(b, n)
  r = 0
  while n != 0
    r += n % b
    n /= b
  end
  r
end

2.upto(87654) do |b|
  p uts f(b, 87654)
end