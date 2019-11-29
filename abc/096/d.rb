require "prime"

arr = []
Prime.each 55555 do |n|
  if n % 5 == 1
    arr << n
    break if arr.length >= 55
  end
end

p arr