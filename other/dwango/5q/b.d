import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto as = readln.split.to!(long[]);

    long[] ss;
    foreach (i; 0..N) {
        long s;
        foreach (j; i..N) {
            s += as[j];
            ss ~= s;
        }
    }

    long r;
    foreach_reverse (i; 0..42) {
        auto x = 1L<<i;
        long[] nss;
        foreach (s; ss) if (s & x) {
            nss ~= s;
        }
        if (nss.length >= K) {
            ss = nss;
            r |= x;
        }
    }
    writeln(r);
}