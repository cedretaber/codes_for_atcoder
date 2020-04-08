import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp.to!(char[]);
    auto t = readln.chomp.to!(char[]);
    if (s.length != t.length) {
        writeln(-1);
        return;
    }
    s.reverse();
    t.reverse();

    foreach (i; 0..s.length+1) {
        if (s == t) {
            writeln(i);
            return;
        }
        s = s[1..$] ~ s[0];
    }
    writeln(-1);
}