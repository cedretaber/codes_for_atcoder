import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto DP = new int[][][](N, N, N);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    int solve(int i, int j, int e) {
        if (i == e || j == N) return 0;
        if (DP[i][j][e] == -1) {
            int r = max(solve(i+1, j, e), solve(i, j+1, e));
            r = max(r, solve(i+1, j+1, e) + (S[i] == S[j] ? 2 : 0));
            DP[i][j][e] = r;
        }
        return DP[i][j][e];
    }

    int r;
    foreach (i; 1..N) {
        r = max(r, solve(0, i, i));
    }
    writeln(N - r);
}