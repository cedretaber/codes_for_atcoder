import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

long[3] DR = [1, 100, 10000];

void main()
{
    auto dn = readln.split.to!(long[]);
    auto D = dn[0];
    auto N = dn[1];
    if (N == 100) ++N;
    writeln(N * DR[D]);
}