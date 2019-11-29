n, m, p = gets.split.map(&:to_i)
t = Array.new(n) { [] }
m.times do
  a, b, c = gets.split.map(&:to_i)
  t[a-1] << [b-1, c-p]
end

inf = Float::INFINITY
memo = Array.new(n) { -inf }
memo[0] = 0
fs = Array.new(n, false)
fs[0] = true
stk = [[:go, 0]]
until stk.empty?
  d, i = stk.pop
  if d == :back
    fs[i] = false
  else
    t[i].each do |to, c|
      if fs[to]
        if memo[to] < memo[i] + c
          memo[to] = inf
          stk << [:go, to]
        end
      else
        if memo[to] < memo[i] + c
          memo[to] = memo[i] + c
          fs[i] = true
          stk << [:back, i] << [:go, to]
        end
      end
    end
  end
end

puts memo.last.abs == inf ? -1 : [0, memo.last].max