import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(long[]);
    auto k2 = ab[0] + ab[1];
    writeln(k2%2 == 1 ? "IMPOSSIBLE" : (k2 / 2).to!string);
}