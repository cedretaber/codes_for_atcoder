import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);

    foreach (a; as) if (a >= N) goto solve;
    writeln(0);
    return;
    solve:

    long l, r = (10L^^16+1000)*N+1;
    while (l+1 < r) {
        auto m = (l+r)/2;
        auto aa = as.dup;
        auto K = m;
        auto ds = new long[](N);
        long d;
        for (;;) {
            ds[] = 0;
            d = 0;
            foreach (i, ref a; aa) {
                if (i) ds[i] += ds[i-1];
                a += d;
                if (a >= N) {
                    auto x = a / N;
                    if (K < x) goto ng;
                    K -= x;
                    a %= N;
                    ds[i] += x;
                    d += x;
                }
            }
            bool ok = true;
            foreach (i, ref a; aa) {
                a += d - ds[i];
                if (a >= N) ok = false;
            }
            if (ok) break;
        }
        r = m;
        continue;
        ng:
        l = m;
    }
    writeln(r);
}