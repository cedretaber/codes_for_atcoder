import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nml = readln.split.to!(int[]);
    auto N = nml[0];
    auto M = nml[1];
    auto L = nml[2];

    auto pqr = readln.split.to!(int[]);
    sort(pqr);

    int r;
    do {
        auto P = pqr[0];
        auto Q = pqr[1];
        auto R = pqr[2];

        r = max(r, (N/P) * (M/Q) * (L/R));
    } while (nextPermutation(pqr));
    writeln(r);
}