import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto c1 = readln.chomp;
    auto c2 = readln.chomp;
    writeln(c1[0] == c2[2] && c1[1] == c2[1] && c1[2] == c2[0] ? "YES" : "NO");
}