n, a, b, c = gets.split.map(&:to_i)

ls = Array.new(n) { gets.chomp.to_i }

mp = 1.0/0

3.upto(n) do |m|
  ls.permutation(m) do |ns|
    1.upto(m-2) do |ai|
      (ai+1).upto(m-1) do |bi|
        x = (ai - 1) * 10 + (bi - ai - 1) * 10 + (m - bi - 1) * 10 
        x += (a - ns[0...ai].reduce(:+)).abs
        x += (b - ns[ai...bi].reduce(:+)).abs
        x += (c - ns[bi..-1].reduce(:+)).abs
        mp = mp < x ? mp : x
      end
    end
  end
end

puts mp