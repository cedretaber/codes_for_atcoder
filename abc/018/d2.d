import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range, core.bitop;

alias C = Tuple!(int, "to", long, "h");

void main()
{
    auto nmpqr = readln.split.to!(int[]);
    auto N = nmpqr[0];
    auto M = nmpqr[1];
    auto P = nmpqr[2];
    auto Q = nmpqr[3];
    auto R = nmpqr[4];
    auto G = new C[][N];
    foreach (_; 0..R) {
        auto xyz = readln.split.to!(int[]);
        auto x = xyz[0]-1;
        auto y = xyz[1]-1;
        long z = xyz[2];
        G[x] ~= C(y, z);
    }

    long max_h;
    foreach (b; 0..1<<N) if (popcnt(b) == P) {
        auto bs = new long[](M);
        foreach (i; 0..N) if (b & (1<<i)) {
            foreach (c; G[i]) bs[c.to] += c.h;
        }
        sort!"a > b"(bs);
        long h;
        foreach (i; 0..Q) h += bs[i];
        max_h = max(max_h, h);
    }
    writeln(max_h);
}