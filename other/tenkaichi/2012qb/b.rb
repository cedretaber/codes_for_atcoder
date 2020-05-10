w = gets.chomp.chars

front = w.take_while { |c| c == '_' }.join
w = w[front.length..-1]
w.reverse!
back = w.take_while { |c| c == '_' }.join
w = w[back.length..-1]
w.reverse!
w = w.join

if /_/ =~ w && /[A-Z]/ !~ w
  if w.split('_').all? { |ww| ww.length > 0 && /^[a-z][a-z0-9]*$/ =~ ww }
    w.gsub!(/_(.)/) { $1.upcase }
    puts front + w + back
    exit 0
  end
end

if /^[^A-Z].*[A-Z]/ =~ w && /_/ !~ w
  if w.split(/(?=[A-Z])/).all? { |ww| ww.length > 0 && /^.[a-z0-9]*$/ =~ ww }
    w.gsub!(/([A-Z])/) { "_#{$1.downcase}" }
    puts front + w + back
    exit 0
  end
end

puts front + w + back