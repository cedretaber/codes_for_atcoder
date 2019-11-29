import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[365][365] DP;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];
    auto AS = readln.split.to!(long[]);

    long solve(int n, int m) {
        if (m == M && n == N) return 0;
        if (m == M || n == N) return long.min / 3;
        if (DP[n][m]) return DP[n][m];
        long r = long.min / 3;
        foreach (nn; n+1..min(N+1, n+K+1)) {
            r = max(r, solve(nn, m+1) + AS[n]);
        }
        return DP[n][m] = r;
    }

    long r = -1;
    foreach (i; 0..K) {
        r = max(r, solve(i, 0));
    }
    writeln(r);
}