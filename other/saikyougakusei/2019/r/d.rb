n = gets.to_i
a = Array.new(n-1)
x = 1
s = 2
a.each.with_index do |e, i|
  next unless e.nil?
  while i < n-1
    a[i] = x
    i += s
  end
  x += 1
  s *= 2
end

(n-1).times do |i|
  puts a[0...n-i-1] * " "
end