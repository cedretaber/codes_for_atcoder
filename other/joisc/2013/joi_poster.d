import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum real EPS = 1e-11;

void main()
{
    auto nwh = readln.split.to!(long[]);
    auto N = nwh[0];
    auto W = nwh[1];
    auto H = nwh[2];

    long[] xs, ys;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(long[]);
        xs ~= xy[0];
        ys ~= xy[1];
    }

    int c;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (i == j) continue;

            auto r1 = (xs[i]-xs[j])^^2 + (ys[i]-ys[j])^^2;
            if (r1 > (W-xs[i])^^2 || xs[i]^^2 < r1 || r1 > (H-ys[i])^^2 || ys[i]^^2 < r1) continue;

            foreach (k; 0..N) {
                if (i == k || j == k) continue;
                foreach (l; 0..N) {
                    if (i == l || j == l || k == l) continue;

                    auto r2 = (xs[k]-xs[l])^^2 + (ys[k]-ys[l])^^2;
                    auto d = (xs[i]-xs[k])^^2 + (ys[i]-ys[k])^^2;
                    if (r1 > r2 && r1 + r2 - d >= 0 && (r1 + r2 - d)^^2 > 4 * r1 * r2) ++c;
                }
            }
        }
    }
    writeln(c);
}