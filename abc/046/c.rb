$stdin.read.split(?\n)[1..-1].map { |ta| ta.split.map(&:to_i) }.tap do |(t, a), *rest|
  rest.each do |nt, na|
    if (tx = (t+nt-1)/nt) > (ax = (a+na-1)/na)
      t = nt * tx
      a = na * tx
    else
      t = nt * ax
      a = na * ax
    end
  end

  puts t + a
end