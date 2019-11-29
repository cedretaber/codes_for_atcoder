n = gets.chomp.to_i

puts "? #{[*1..n].join(" ")}"
$stdout.flush
x = gets.chomp

l = 1
r = n+1
while l+1 < r
  m = (l+r)/2
  puts "? #{[*m...m+n].join " "}"
  $stdout.flush
  y = gets.chomp
  if x == y
    l = m
  else
    r = m
  end
end

s = r
half = [*s...s+n-1].join(" ")
half = " " + half if !half.empty?

ans = Array.new(n*2)
h = {"Red" => "R", "Blue" => "B"}

(1...s).each do |i|
  puts "?#{half} #{i}"
  $stdout.flush
  ans[i-1] = h[gets.chomp]
end
(s+n..n*2).each do |i|
  puts "?#{half} #{i}"
  $stdout.flush
  ans[i-1] = h[gets.chomp]
end

half = [*1...s-1, *s+n..n*2].join(" ")
half = " " + half if !half.empty?
(s..s+n-1).each do |i|
  puts "?#{half} #{i}"
  $stdout.flush
  ans[i-1] = h[gets.chomp]
end

puts "! #{ans.join}"
$stdout.flush