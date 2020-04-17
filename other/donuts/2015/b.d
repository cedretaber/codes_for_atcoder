import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = readln.split.to!(long[]);
    long[] bs;
    uint[] xs;
    foreach (_; 0..M) {
        auto ii = readln.split.to!(int[]);
        bs ~= ii[0];
        uint x;
        foreach (i; ii[2..$]) x |= 1<<(i-1);
        xs ~= x;
    }
    long r;
    foreach (x; 0..1<<N) {
        if (popcnt(x) != 9) continue;
        long rr;
        foreach (i; 0..N) if (x & (1<<i)) rr += as[i];
        foreach (i; 0..M) if (popcnt(xs[i] & x) >= 3) rr += bs[i];
        r = max(r, rr);
    }
    writeln(r);
}