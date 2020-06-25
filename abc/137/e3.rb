n, m, p = gets.split.map(&:to_i)
es = Array.new(m) {
  a, b, c = gets.split.map(&:to_i)
  [a-1, b-1, c - p]
}
ds = Array.new(n) { :inf }
ds[0] = 0
n.times do
  es.each do |e|
    ds[e[1]] = ds[e[0]] + e[2] if ds[e[0]] != :inf && (ds[e[1]] == :inf || ds[e[1]] < ds[e[0]] + e[2])
  end
end
x = ds.last
n.times do
  es.each do |e|
    ds[e[1]] = 10**9 if ds[e[0]] != :inf && (ds[e[1]] == :inf || ds[e[1]] < ds[e[0]] + e[2])
  end
end
puts(x != ds.last ? -1 : [x, 0].max)