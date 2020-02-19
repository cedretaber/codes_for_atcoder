puts gets.chomp.gsub(/(?:o+)ookayama/) { |w|
  while /oo/ =~ w
    w.sub!("oo", "O")
    w.sub!("OO", "o")
  end
  w
}