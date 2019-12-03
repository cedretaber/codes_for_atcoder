import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto na = readln.split.to!(int[]);
    auto N = na[0];
    auto A = na[1];
    auto xs = readln.split.to!(int[]);

    auto DP = new long[][][](N, N, N*50+1);
    foreach (ref a; DP) foreach (ref b; a) foreach (ref c; b) c = -1;
    long solve(int i, int n, int s) {
        if (i == N) return n != 0 && s / n == A && s % n == 0 ? 1 : 0;
        if (DP[i][n][s] == -1) {
            DP[i][n][s] = solve(i+1, n, s) + solve(i+1, n+1, s + xs[i]);
        }
        return DP[i][n][s];
    }
    writeln(solve(0, 0, 0));
}