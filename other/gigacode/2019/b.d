import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nxyz = readln.split.to!(int[]);
    auto N = nxyz[0];
    auto X = nxyz[1];
    auto Y = nxyz[2];
    auto Z = nxyz[3];
    int r;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0];
        auto B = ab[1];
        if (A >= X && B >= Y && A+B >= Z) ++r;
    }
    writeln(r);
}