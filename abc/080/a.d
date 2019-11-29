import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto nab = readln.split.to!(int[]);
    writeln(nab[0] * nab[1] > nab[2] ? nab[2] : nab[0] * nab[1]);
}