cs = gets.chomp

f, cs =
  if cs.start_with?("0")
    i = cs.chars.take_while { |c| c == "0" }.length
    [10**i, cs[i..-1]]
  else
    [cs[0].to_i, cs[1..-1]]
  end

f.to_s.length.upto([f.to_s.length, cs.length].max) do |i|
  c = cs[0...i]
  d = c.empty? ? 1 : c.to_i - f
  next if d < 0

  es = cs[i..-1] || ""
  c = (c.to_i + d).to_s
  ok = true
  until es.empty?
    if es.length < c.length
      ok = false unless es.empty? || c.start_with?(es)
      break
    else
      if !es.start_with?(c)
        ok = false
        break
      end
    end
    es = es[c.length..-1]
    c = (c.to_i + d).to_s
  end

  if ok
    puts "#{f} #{d}"
    exit
  end
end