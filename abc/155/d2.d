import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    long[] ps, ns;
    long zc, nc, pc;
    foreach (a; readln.split.to!(long[])) {
        if (a > 0) {
            ps ~= a;
        } else if (a < 0) {
            ns ~= -a;
        } else {
            ++zc;
        }
    }
    zc = zc * (zc-1) / 2L + zc * (N-zc);
    nc = (ps.length * ns.length).to!long;

    if (K <= nc) {
        sort!"a > b"(ns);
        sort!"a > b"(ps);
        if (K == nc) {
            writeln(-ns[$-1] * ps[$-1]);
            return;
        }
        long l = ns[0] * ps[0] + 1, r;
        while (l > r+1) {
            auto m = (l+r)/2;
            long k;
            foreach (p; ps) {
                if (p * ns[0] < m) continue;
                long ll, rr = ns.length.to!long;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (p * ns[mm] >= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                k += rr;
            }
            if (k < K) {
                l = m;
            } else {
                r = m;
            }
        }
        writeln(-r);
    } else if (K <= nc + zc) {
        writeln(0);
    } else {
        sort!"a < b"(ns);
        sort!"a < b"(ps);
        K -= nc + zc;
        long l, r = 10L^^18+1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            long k;
            foreach (i; 0..ns.length.to!long-1) {
                if (ns[i] * ns[i+1] > m) continue;
                long ll = i+1, rr = ns.length.to!long;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (ns[i] * ns[mm] <= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                k += ll - i;
            }
            foreach (i; 0..ps.length.to!long-1) {
                if (ps[i] * ps[i+1] > m) continue;
                long ll = i+1, rr = ps.length.to!long;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (ps[i] * ps[mm] <= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                k += ll - i;
            }
            if (k < K) {
                l = m;
            } else {
                r = m;
            }
        }
        writeln(r);
    }
}