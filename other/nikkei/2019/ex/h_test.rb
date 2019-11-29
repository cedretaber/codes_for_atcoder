arr = [false]

(1..10000).each do |i|
  t = false
  t ||= !arr[i-1]
  t ||= (i >= 8 && !arr[i-8])
  t ||= (i >= 8**2 && !arr[i-8**2])
  t ||= (i >= 8**3 && !arr[i-8**3])
  arr[i] = t
end

last = 0
arr.each.with_index do |a, i|
  if i > 0 && a == arr[i-1]
    puts "#{i-1} #{i}"
    puts (i - 1 - last)
    last = i - 1
  end
end