def f n, k
  return "b" if n == 1
  return "a" if n == 2

  if k%2 == 0
    f(n-1, k/2) + f(n-2, k/4)
  else
    f(n-2, k/4) + f(n-1, k/2)
  end
end

n, k = gets.split.map(&:to_i)
puts f(n, k)