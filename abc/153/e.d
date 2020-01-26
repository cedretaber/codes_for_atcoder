import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hn = readln.split.to!(int[]);
    long H = hn[0];
    auto N = hn[1];
    long[] AS, BS;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        AS ~= ab[0];
        BS ~= ab[1];
    }

    auto DP = new long[][](N, H+1);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, long h) {
        if (i == N) return h == 0 ? 0 : long.max/3;
        if (DP[i][h] == -1) {
            if (h == 0) {
                DP[i][h] = solve(i+1, h);
            } else {
                DP[i][h] = min(solve(i+1, h), solve(i, max(0, h - AS[i])) + BS[i]);
            }
        }
        return DP[i][h];
    }
    writeln(solve(0, H));
}