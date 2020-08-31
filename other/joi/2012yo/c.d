import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    auto C = readln.chomp.to!int;
    int[] DS;
    foreach (_; 0..N) DS ~= readln.chomp.to!int;

    auto DP = new int[][](N+1, N+1);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            DP[i+1][j] = max(DP[i+1][j], DP[i][j]);
            DP[i+1][j+1] = max(DP[i+1][j+1], DP[i][j] + DS[i]);
        }
        DP[i+1][N] = max(DP[i+1][N], DP[i][N]);
    }
    int r;
    foreach (n; 1..N+1) r = max(r, (C + DP[N][n]) / (A + B*n));
    writeln(r);
}