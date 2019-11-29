import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    double r = 0;
    foreach (n; 1..(N+1)) {
        double x = 1.0 / N.to!double;
        while (n < K) {
            n *= 2;
            x /= 2;
        }
        r += x;
    }
    writefln("%0.12f", r);
}