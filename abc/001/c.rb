deg, dis = gets.split.map(&:to_i)
dis = (dis.to_f / 60.0).round(1)

dis =
  case dis
  when 0.0..0.2; 0
  when 8.0..10.7; 5
  when 24.5..28.4; 10
  when 0.3..1.5; 1
  when 10.8..13.8; 6
  when 28.5..32.6; 11
  when 1.6..3.3; 2
  when 13.9..17.1; 7
  when 3.4..5.4; 3
  when 17.2..20.7; 8
  when 5.5..7.9; 4
  when 20.8..24.4; 9
  else 12
  end

if dis == 0
  puts "C 0"
  exit
end

deg =
  case deg * 10
  when 16875...19125; "S"
  when 1125...3375; "NNE"
  when 19125...21375; "SSW"
  when 3375...5625; "NE"
  when 21375...23625; "SW"
  when 5625...7875; "ENE"
  when 23625...25875; "WSW"
  when 7875...10125; "E"
  when 25875...28125; "W"
  when 10125...12375; "ESE"
  when 28125...30375; "WNW"
  when 12375...14625; "SE"
  when 30375...32625; "NW"
  when 14625...16875; "SSE"
  when 32625...34875; "NNW"
  else "N"
  end

puts "#{deg} #{dis}"