import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto c = 1;
    long h;
    long[] ps, cs, ms;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        auto A = ab[0];
        auto B = ab[1];
        if (A != 0 && B >= 0) {
            h += B;
            c += A-1;
        } else if (A == 0 && B > 0) {
            ps ~= B;
        } else if (A > 1 && B < 0) {
            cs ~= A-1;
            ms ~= B;
        }
    }
    sort!"a > b"(ps);
    foreach (i; 0..min(c, ps.length)) h += ps[i];
    if (ps.length <= c || ms.empty) {
        writeln(h);
        return;
    }

    auto DP = new long[][](ms.length+1, ps.length+1);
    foreach (ref dp; DP) dp[] = long.min/3;
    DP[0][0] = 0;
    foreach (i; 0..ms.length) foreach (j; 0..ps.length+1) {
        DP[i+1][j] = max(DP[i+1][j], DP[i][j]);
        auto jj = min(ps.length, j + cs[i]);
        DP[i+1][jj] = max(DP[i+1][jj], DP[i][j] + ms[i]);
    }

    auto ds = new long[](ps.length+1);
    ds[$-1] = long.min/3;
    foreach_reverse (i; 0..ps.length+1) {
        if (i < ps.length) ds[i] = ds[i+1];
        ds[i] = max(ds[i], DP[ms.length][i]);
    }
    auto max_h = h;
    foreach (i; c..ps.length) {
        h += ps[i];
        max_h = max(max_h, h + ds[i - c + 1]);
    }
    writeln(max_h);
}