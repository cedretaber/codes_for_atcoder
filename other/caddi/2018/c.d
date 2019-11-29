import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto np = readln.split.to!(long[]);
    auto N = np[0];
    auto P = np[1];
    if (N == 1) {
        writeln(P);
        return;
    }
    long r = 1;
    auto p = P;
    for (long x = 2; x^^2 <= P; ++x) {
        long y;
        while (p%x == 0) {
            ++y;
            p /= x;
        }
        r *= x^^(y/N);
    }
    writeln(r);
}