puts gets.chomp.chars.group_by(&:itself).all? { |_, n| n.length.even? } ? "Yes" : "No"