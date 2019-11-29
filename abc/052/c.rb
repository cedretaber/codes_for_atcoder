require "prime"

arr = Array.new(1000) { 0 }

n = gets.chomp.to_i
2.upto(n) do |is|
  Prime.prime_division(is).each do |i, pi|
    arr[i] += pi
  end
end

wp = 10**9+7

puts arr.reduce(1) { |a, i|
  next a if i.zero?
  a * (i+1) % wp
}