import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    long[] xs, ys, zs;
    foreach (_; 0..N) {
        auto xyz = readln.split.to!(long[]);
        xs ~= xyz[0];
        ys ~= xyz[1];
        zs ~= xyz[2];
    }

    long max_p;
    foreach (x; 0..8) {
        auto a = x&1 ? 1 : -1;
        auto b = x&2 ? 1 : -1;
        auto c = x&4 ? 1 : -1;

        auto DP = new long[][](N, M+1);
        foreach (ref dp; DP) dp[] = -1;
        long solve(int i, int m) {
            if (m == 0) return 0;
            if (i == N) return long.min/3;

            if (DP[i][m] == -1) {
                DP[i][m] = max(solve(i+1, m), solve(i+1, m-1) + xs[i]*a + ys[i]*b + zs[i]*c);
            }
            return DP[i][m];
        }
        max_p = max(max_p, solve(0, M));
    }
    writeln(max_p);
}