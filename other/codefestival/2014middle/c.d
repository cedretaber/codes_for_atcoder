import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

real pow(real x, long n) {
    real y = 1.0;
    while (n) {
        if (n%2 == 1) y *= x;
        x = x * x;
        n /= 2;
    }
    return y;
}

void main()
{
    auto pn = readln.split;
    auto p = pn[0].to!real;
    auto N = pn[1].to!long;

    writefln!"%.12f"(0.5 * (1.0 - pow(1.0 - 2.0 * p, N)));
}