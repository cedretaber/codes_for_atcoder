import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);

    long l, r = 10^^9;
    while (l+1 < r) {
        auto m = (l+r)/2;
        long k;
        foreach (a; AS) k += max(0, a-m);
        if (k > K) {
            l = m;
        } else {
            r = m;
        }
    }
    foreach (a; AS) K -= max(0, a-r);
    long p;
    foreach (i; 0..N) {
        auto a = min(r, AS[i]);
        if (K > 0 && a > 1) {
            K -= 1;
            a -= 1;
        }
        writeln(a);
        p += a*2 + 1;
        if (i == 0) {
            p += a;
        } else {
            p += abs(a - AS[i-1]);
        }
        if (i == N-1) p += a;
    }
    writeln(p);
}