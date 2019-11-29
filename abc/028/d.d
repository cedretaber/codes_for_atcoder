import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(double[]);
    auto N = nk[0];
    auto K = nk[1];

    auto r = ( (K-1)*(N-K)*6 + N*3-2 ) / N^^3;
    writefln("%0.9f", r);
}