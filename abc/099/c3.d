import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;

    auto r = long.max;
    foreach (x; 0..N+1) {
        long rr;

        auto a = x;
        while (a) rr += a%6, a /= 6;

        auto b = N-x;
        while (b) rr += b%9, b /= 9;

        r = min(r, rr);
    }
    writeln(r);
}