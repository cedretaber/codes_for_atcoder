@P = 10**9+7

def pow x, n
  y = 1
  while n != 0
    y = y * x % @P if n%2 == 1
    x = x**2 % @P;
    n /= 2
  end
  y
end

def inv x
  pow x, @P-2
end

@L = gets.to_i
if @L < 9
  puts 0
  exit
end

l = 2
r = 10**13
while l+1 < r
  m = (l+r) / 2
  if (m+1)*3 <= @L
    l = m
  else
    r = m
  end
end

l %= @P
res = l * ((l-1+@P) % @P) % @P * inv(2) % @P
t = @L - (r*2+4)
if t > 0
  t %= @P
  if t%2 == 0
    res = (res + (t+2) * t % @P * inv(4) % @P) % @P
  else
    res = (res + (t+1) * (t+1) % @P * inv(4) % @P) % @P
  end
end

if @L >= 13
  l = 0
  r = 10**13
  while l+1 < r
    m = (l+r) / 2
    if 13 + 4*m <= @L
      l = m
    else
      r = m
    end
  end
  t = @L - (12 + 3*r);
  r %= @P;
  res = (res + r * (r+1) % @P * inv(2) % @P) % @P;
  if t > 0
    t %= @P
    if t%3 == 0
      res = (res + (t + 3) * t % @P * inv(6) % @P) % @P;
    else
      res = (res + (t + t%3) * (t+3-t%3) % @P * inv(6) % @P) % @P;
    end
  end
end

p res