import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!long;

    auto p = S.to!double.sqrt.to!long;
    if (p^^2 < S) ++p;
    auto d = p^^2 - S;

    writefln("%d %d %d %d %d %d", 0, 0, p, 1, d, p);
}