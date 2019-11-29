import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto na = readln.split.to!(int[]);
    auto N = na[0];
    auto A = na[1];
    writefln("%d %d", (A+2)/3, min(N/3, A));
}