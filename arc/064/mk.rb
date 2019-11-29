cs = [*?a..?z]

s = ""

(10**5).times do
  c = nil
  while c.nil?
    c = cs.sample
    c = nil if s[-1] == c
  end
  s += c
end

puts s