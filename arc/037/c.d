import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto as = readln.split.to!(long[]);
    auto bs = readln.split.to!(long[]);
    sort(bs);

    long l = 0, r = 10L^^18;
    while (l+1 < r) {
        long k;
        auto m = (l+r)/2;
        foreach (a; as) {
            if (a * bs[0] > m) continue;
            long ll, rr = N;
            while (ll+1 < rr) {
                auto mm = (ll+rr)/2;
                if (a * bs[mm] <= m) {
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
    writeln(r);
}