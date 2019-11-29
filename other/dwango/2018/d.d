import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[20] XS;
int[][20] AS;
long[uint] DP;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i, x; readln.split.to!(long[])) XS[i] = x;
    foreach (int i, a; readln.split.to!(size_t[])) AS[a-1] ~= i+1;
}