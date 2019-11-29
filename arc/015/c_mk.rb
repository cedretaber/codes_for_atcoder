puts 200
n = "a"
arr = []
11.times do |i|
  arr << "#{n} #{i+1} #{n.succ}"
  n = n.succ
end
n = n.succ
18.times do
  10.times do |i|
    arr << "#{n} #{i+1} #{n.succ}"
    n = n.succ
  end
  n = n.succ
end
9.times do |i|
  arr << "#{n} #{i+1} #{n.succ}"
  n = n.succ
end
arr.shuffle.each do |l| puts l end