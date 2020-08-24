import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias B = Tuple!(int, "l", int, "h");

void main()
{
    auto nmhk = readln.split.to!(int[]);
    auto N = nmhk[0];
    auto M = nmhk[1];
    auto K = nmhk[3];
    long[] ps;
    foreach (_; 0..N) ps ~= readln.chomp.to!long;
    B[] bs;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        bs ~= B(ab[0]-1, ab[1]);
    }
    sort!"a.h < b.h"(bs);
    int[][] cs;
    auto ii = 0.iota(N).array;
    foreach (b; bs) {
        auto x = ii[b.l];
        auto y = ii[b.l+1];
        if (x > y) swap(x, y);
        cs ~= [x, y];
        swap(ii[b.l], ii[b.l+1]);
    }
    auto qs = new long[](N);
    foreach (i, j; ii) qs[j] = ps[i];

    long r;
    foreach (c; cs) if (c[0] < K && c[1] >= K) r = min(r, qs[c[1]] - qs[c[0]]);
    writeln(qs[0..K].sum() + r);
}