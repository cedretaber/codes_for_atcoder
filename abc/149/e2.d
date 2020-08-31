import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto AS = readln.split.to!(long[]);
    sort!"a > b"(AS);

    long l = AS[0]*2+1, r = AS[$-1]*2;
    while (l > r+1) {
        auto m = (l+r)/2;
        long count;
        foreach (a; AS) {
            if (a + AS[0] < m) continue;
            long ll, rr = N;
            while (ll+1 < rr) {
                auto mm = (ll+rr)/2;
                if (a + AS[mm] >= m) {
                    ll = mm;
                } else {
                    rr = mm;
                }
            }
            count += rr;
        }
        if (count < M) {
            l = m;
        } else {
            r = m;
        }
    }

    auto cs = new long[](N);
    foreach (i; 0..N) {
        if (i) cs[i] = cs[i-1];
        cs[i] += AS[i];
    }

    long res, count;
    foreach (a; AS) {
        if (a + AS[0] < r) continue;
        long ll, rr = N;
        while (ll+1 < rr) {
            auto mm = (ll+rr)/2;
            if (a + AS[mm] >= r) {
                ll = mm;
            } else {
                rr = mm;
            }
        }
        count += rr;
        res += a * rr + cs[ll];
    }
    writeln(res - r * (count - M));
}