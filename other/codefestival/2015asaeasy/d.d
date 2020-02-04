import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto DP = new int[][](N, N);
    int solve(int i, int j, int x) {
        if (i == x || j == N) return 0;
        if (DP[i][j] == -1) {
            int r = max(solve(i+1, j, x), solve(i, j+1, x));
            r = max(r, solve(i+1, j+1, x) + (S[i] == S[j] ? 2 : 0));
            DP[i][j] = r;
        }
        return DP[i][j];
    }
    int r;
    foreach (x; 1..N) {
        foreach (ref dp; DP) dp[] = -1;
        r = max(r, solve(0, x, x));
    }
    writeln(N - r);
}