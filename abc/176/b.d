import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp;
    int s;
    foreach (c; N) s += (c - '0').to!int;
    writeln(s%9 == 0 ? "Yes" : "No");
}