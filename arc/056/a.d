import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto abkl = readln.split.to!(long[]);
    auto A = abkl[0];
    auto B = abkl[1];
    auto K = abkl[2];
    auto L = abkl[3];

    auto r = long.max;
    r = min(r, A*K);
    r = min(r, (K+L-1)/L*B);
    r = min(r, K/L*B + K%L*A);
    writeln(r);
}