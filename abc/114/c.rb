n = gets.chomp.to_i

cnt = 0
3.upto(9) do |l|
  cnt += [7,5,3]
    .repeated_permutation(l)
    .map { |a| a.join }
    .select { |s| s.include?("7") && s.include?("5") && s.include?("3") && s.to_i <= n }
    .length
end

puts cnt