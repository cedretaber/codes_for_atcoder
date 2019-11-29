import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nt = readln.split.to!(int[]);
    auto N = nt[0];
    auto T = nt[1];
    auto abs = new int[][](N, 2);
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        abs[i][0] = ab[0];
        abs[i][1] = ab[1];
    }
    sort!"a[0] < b[0]"(abs);
    auto DP = new int[][](N, T);
    int solve(int i, int t) {
        if (i == N || t >= T) return 0;
        if (DP[i][t] == 0) DP[i][t] = max(solve(i+1, t), solve(i+1, t+abs[i][0]) + abs[i][1]);
        return DP[i][t];
    }
    writeln(solve(0, 0));
}