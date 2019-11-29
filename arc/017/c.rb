n, x = gets.split.map(&:to_i)
ws = n.times.map { gets.to_i }

def zr ws
  ws.reduce([0]) { |ns, w|
    ns[0...ns.length].each do |n|
      ns << w + n
    end
    ns
  }
end

ns = zr ws[0...n/2]
nd = zr(ws[n/2..-1]).reduce(Hash.new { 0 }) { |nd, n| nd[n] += 1 and nd }

puts(ns.reduce(0) { |a, n| a + nd[x - n] })