import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

long[1000] XS, IXS, YS, IYS, ZS, IZS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..N) {
        auto xyz = readln.split.to!(long[]);
        XS[i] = xyz[0];
        IXS[i] = -xyz[0];
        YS[i] = xyz[1];
        IYS[i] = -xyz[1];
        ZS[i] = xyz[2];
        IZS[i] = -xyz[2];
    }

    long res = long.min;
    foreach (xs; [XS, IXS]) {
        foreach (ys; [YS, IYS]) {
            foreach (zs; [ZS, IZS]) {
                long[int][1000] memo;
                long solve(int i, int r) {
                    if (r == 0) return 0;
                    if (i == N) return long.min / 2;

                    if (r in memo[i]) return memo[i][r];

                    auto r1 = solve(i+1, r);
                    auto r2 = solve(i+1, r-1) + xs[i] + ys[i] + zs[i];

                    return memo[i][r] = max(r1, r2);
                }
                res = max(res, solve(0, M));
            }
        }
    }

    writeln(res);
}