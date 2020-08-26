import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    long[] hh, ss;
    foreach (i; 0..N) {
        auto hs = readln.split.to!(long[]);
        hh ~= hs[0];
        ss ~= hs[1];
    }
    long l, r = long.max/2;
    auto rs = new long[](N);
    while (l+1 < r) {
        auto m = (l+r)/2;
        foreach (i; 0..N) {
            if (m < hh[i]) goto ng;
            rs[i] = (m - hh[i]) / ss[i];
        }
        sort(rs);
        foreach (i; 0..N) if (rs[i] < i) goto ng;
        r = m;
        continue;
        ng:
        l = m;
    }
    writeln(r);
}