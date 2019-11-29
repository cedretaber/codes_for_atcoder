op = ["", "*", "**"]
(34425..20181224).each do |x|
  s = x.to_s.chars
  len = s.length-1
  empty = [""] * len
  op.repeated_permutation(len) do |ops|
    next if ops == empty
    y =
      begin
        eval(s.zip(ops).join).to_i
      rescue SyntaxError, FloatDomainError => e
        nil
      end
    if y == x
      puts x
      break
    end
  end
end