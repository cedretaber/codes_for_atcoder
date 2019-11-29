import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp.to!(char[]);
    if (s[0] == s[$-1] && s.length%2 == 0 || s[0] != s[$-1] && s.length%2 == 1) {
        writeln("First");
    } else {
        writeln("Second");
    }
}