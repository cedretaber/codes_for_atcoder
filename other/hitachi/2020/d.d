import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias TI = Tuple!(long, "t", int, "i");

void main()
{
    auto nt = readln.split.to!(long[]);
    auto N = nt[0];
    auto T = nt[1];

    long[] as, bs;
    long min_t = long.max;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        auto a = ab[0];
        auto b = ab[1];
        as ~= a;
        bs ~= b;
        min_t = min(min_t, a + b);
    }

    if (min_t > T) {
        writeln(0);
        return;
    }

    long d;
    for (d = 1; d^^2 <= T;) ++d;
    auto fs = new TI[][](d+1, N);
    foreach (dd; 0..d) {
        auto t = T/d * dd + 1;
        foreach (i; 0..N) {
            fs[dd][i] = as[i] * t + bs[i];
        }
        sort!"a.t < b.t"(fs[dd]);
    }
    foreach (i; 0..N) {
        fs[d][i] = as[i] * T + bs[i];
    }

    bool[int] visited;
    auto t = fs[0][0].t;
    visited[fs[0][0].i] = true;
    for (;;) {
        int l, r = d;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (m <= t) {
                l = m;
            } else {
                r = m;
            }
        }
        auto i = fs[l][0].i;
        int j;
        foreach (ii, ti; fs[r]) if (ti.i == i) j = ii.to!int + 1;
        min_t = long.max;
        forea h
    }
}