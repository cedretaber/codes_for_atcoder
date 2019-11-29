import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];

    auto max_c = min(A, B);
    auto t = A + B - N;
    auto min_c = t < 0 ? 0 : t;
    writefln("%d %d", max_c, min_c);
}