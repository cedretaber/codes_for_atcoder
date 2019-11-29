ns = gets.split.map(&:to_i)

res = []
(0...ns.length).each do |l|
  (l...ns.length).each do |r|
    a = ns[l..r].sort
    p a
    p a[a.length/2]
    res << a[a.length/2]
  end
end

p res.sort
p res.sort[res.length/2]