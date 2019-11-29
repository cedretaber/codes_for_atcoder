import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto mn = readln.split.to!(int[]);
    auto M = mn[0];
    auto N = mn[1];
    writeln(M - M/N*(N-1));
}