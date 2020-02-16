import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    long[] ps, ms;
    long zc;
    foreach (a; readln.split.to!(long[])) {
        if (a < 0) {
            ms ~= -a;
        } else if (a > 0) {
            ps ~= a;
        } else {
            ++zc;
        }
    }
    sort!"a < b"(ps);
    sort!"a < b"(ms);

    auto m_len = (ps.length * ms.length).to!long;
    auto z_len = zc * (N-zc) + zc * (zc-1) / 2;
    if (K <= m_len) {
        long l = -10L^^18-1, r = 0;
        ms.reverse();
        while (l+1 < r) {
            auto m = (r+l)/2;
            long k;
            foreach (p; ps) {
                size_t ll = 0, rr = ms.length;
                if (p * -ms[0] > m) continue;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (p * -ms[mm] <= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                k += rr.to!long;
            }
            if (k < K) {
                l = m;
            } else {
                r = m;
            }
        }
        writeln(r);
    } else if (K <= m_len + z_len) {
        writeln(0);
    } else {
        K -= m_len + z_len;
        long l = 0, r = 10L^^18+1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            long k;
            if (!ps.empty) foreach (i, p; ps[0..$-1]) {
                size_t ll = i+1, rr = ps.length;
                if (p * ps[i+1] > m) continue;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (p * ps[mm] <= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                k += (ll-i).to!long;
            }
            if (!ms.empty) foreach (i, p; ms[0..$-1]) {
                size_t ll = i+1, rr = ms.length;
                if (p * ms[i+1] > m) continue;
                while (ll+1 < rr) {
                    auto mm = (ll+rr)/2;
                    if (p * ms[mm] <= m) {
                        ll = mm;
                    } else {
                        rr = mm;
                    }
                }
                k += (ll-i).to!long;
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