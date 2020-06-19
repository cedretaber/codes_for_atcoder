DATA.read.lines.each_slice(12) do |_, f, _, s, _, _, _, _, e|
  f = f.to_i
  s = s.to_f
  e = e.to_f
  puts "when #{s}..#{e}; #{f}"
end

__END__
風力
0
　　	
0.0
m
/
s
 以上 
0.2
m
/
s
 以下　　	風力
5
　　	
8.0
m
/
s
 以上 
10.7
m
/
s
 以下　　	風力
10
　　	
24.5
m
/
s
 以上 
28.4
m
/
s
 以下　　風力
1
　　	
0.3
m
/
s
 以上 
1.5
m
/
s
 以下　　	風力
6
　　	
10.8
m
/
s
 以上 
13.8
m
/
s
 以下　　	風力
11
　　	
28.5
m
/
s
 以上 
32.6
m
/
s
 以下　　風力
2
　　	
1.6
m
/
s
 以上 
3.3
m
/
s
 以下　　	風力
7
　　	
13.9
m
/
s
 以上 
17.1
m
/
s
 以下　　	風力
3
　　	
3.4
m
/
s
 以上 
5.4
m
/
s
 以下　　	風力
8
　　	
17.2
m
/
s
 以上 
20.7
m
/
s
 以下　　	　風力
4
　　	
5.5
m
/
s
 以上 
7.9
m
/
s
 以下　　	風力
9
　　	
20.8
m
/
s
 以上 
24.4
m
/
s
 以下