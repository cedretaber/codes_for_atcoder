require "prime"

ps = Prime.each(1000).to_a

as = []

n = 0
loop do
  n += 1
  i = 0
  x = 1
  Prime.prime_division(n).reverse.each do |a, b|
    b.times do
      x *= ps[i]**(a-1)
      i += 1
    end
  end
  break if x > 10**17
  as = as[0..-2] while !as.empty? && as.last.last > x
  as << [n, x]
end

p as