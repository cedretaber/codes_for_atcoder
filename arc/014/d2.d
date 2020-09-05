import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto anm = readln.split.to!(long[]);
    auto ALL = anm[0];
    auto N = anm[1];
    auto M = anm[2];
    long u, d, p;
    long[] ds;
    foreach (i; 0..N) {
        auto L = readln.chomp.to!long;
        if (i == 0) {
            u = L-1;
        } else {
            ds ~= L-p-1;
        }
        if (i == N-1) {
            d = ALL - L;
        }
        p = L;
    }
    sort(ds);
    auto cs = new long[](N-1);
    foreach (i, x; ds) {
        if (i) cs[i] = cs[i-1];
        cs[i] += x;
    }

    foreach (_; 0..M) {
        auto xy = readln.split.to!(long[]);
        auto x = xy[0];
        auto y = xy[1];

        auto res = N + min(x, u) + min(y, d);
        if (!ds.empty) {
            if (ds[0] > x+y) {
                res += (x+y) * (N-1);
            } else {
                long l, r = N-1;
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (ds[m] > x+y) {
                        r = m;
                    } else {
                        l = m;
                    }
                }
                res += cs[l] + (x+y) * (N-1-r);
            }
        }
        writeln(res);
    }
}