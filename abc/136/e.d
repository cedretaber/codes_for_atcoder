import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);

    long S;
    foreach (a; AS) {
        S += a;
    }
    long[] rr;
    for (long r = 1; r^^2 <= S+1; ++r) if (S%r == 0) {
        rr ~= r;
        rr ~= S/r;
    }
    sort!"a > b"(rr);

    long[] as;
    as.length = N;

    foreach (x; rr) {
        long s;
        foreach (i, a; AS) {
            auto aa = a % x;
            s += aa;
            as[i] = aa;
        }
        if (s % x) continue;
        long d = s / x;
        sort!"a > b"(as);
        foreach (j; 0..d) s -= as[j];
        if (s <= K) {
            writeln(x);
            return;
        }
    }
}