import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmp = readln.split.to!(long[]);
    auto N = nmp[0];
    auto M = nmp[1];
    auto P = nmp[2];

    long r = 1;
    while (P) {
        if (P%2 == 1) r = (r * N) % M;
        N = N^^2 % M;
        P /= 2;
    }
    writeln(r);
}