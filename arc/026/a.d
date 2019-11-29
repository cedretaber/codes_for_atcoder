import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nab = readln.split.to!(int[]);
    writeln(nab[2] * min(5, nab[0]) + nab[1] * max(0, nab[0] - 5));
}