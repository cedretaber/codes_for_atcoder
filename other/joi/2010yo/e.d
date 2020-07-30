import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 100000L;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto DP = new long[][][][](3, 2, N+1, M+1);
    DP[0][0][0][0] = 1;
    foreach (i; 0..N) {
        foreach (j; 0..M) {
            (DP[1][0][i+1][j] += DP[0][0][i][j]) %= P;
            (DP[2][0][i][j+1] += DP[0][0][i][j]) %= P;

            (DP[1][0][i+1][j] += DP[1][0][i][j]) %= P;
            (DP[2][1][i][j+1] += DP[1][0][i][j]) %= P;

            (DP[1][0][i+1][j] += DP[1][1][i][j]) %= P;

            (DP[1][1][i+1][j] += DP[2][0][i][j]) %= P;
            (DP[2][0][i][j+1] += DP[2][0][i][j]) %= P;

            (DP[2][0][i][j+1] += DP[2][1][i][j]) %= P;
        }
    }
    long s;
    foreach (ref dp1; DP) foreach (ref dp2; dp1) (s += dp2[N-1][M-1]) %= P;
    writeln(s);
}