import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = readln.split.to!(long[]);

    long[] cs, ss;
    cs.length = N;
    ss.length = N;

    long s, sx;
    foreach (i, a; as) {
        s += a;
        if (i < K-1) continue;
        if (i >= K) s -= as[i-K];
        cs[i-K+1] = s;
    }
    foreach (a; as) if (a > 0) sx += a;
    s = 0;
    foreach (i, a; as) {
        if (a > 0) s += a;
        if (i < K-1) continue;
        if (i >= K && as[i-K] > 0) s -= as[i-K];
        ss[i-K+1] = sx - s;
    }

    long r;
    foreach (i; 0..N-K+1) r = max(r, ss[i], ss[i] + cs[i]);
    writeln(r);
}