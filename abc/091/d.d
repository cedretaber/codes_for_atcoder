import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long bsearch(long n, long[] hs) {
    if (hs[0] >= n) return -1;
    long l, r = hs.length.to!long;
    while (l+1 < r) {
        auto m = (l+r)/2;
        if (hs[m] < n) {
            l = m;
        } else {
            r = m;
        }
    }
    return l;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    auto bs = readln.split.to!(long[]);

    ulong res;
    foreach (i; 0..30) {
        long[] BS;
        foreach (b; bs) BS ~= b % (1L<<(i+1));
        sort(BS);
        long c;
        foreach (aa; as) {
            auto a = aa % (1L<<(i+1));
            auto s = bsearch((1L<<i) - a, BS);
            auto t = bsearch((1L<<i)*2 - a, BS);
            auto u = bsearch((1L<<i)*3 - a, BS);
            auto v = bsearch((1L<<i)*4 - a, BS);
            c += t-s + v-u;
        }
        if (c%2 == 1) res |= 1L<<i;
    }
    writeln(res);
}