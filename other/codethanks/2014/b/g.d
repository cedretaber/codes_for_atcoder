import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto P = readln.chomp.to!int;

    auto DP = new int[][][](2, N+1, N+1);
    bool solve(int t, int n, int p) {
        if (n == 0) return false;
        if (DP[t][n][p] == 0) {
            bool win;
            foreach (s; 1..min(n+1, p+2)) {
                win = win || !solve((t+1)%2, n-s, s);
            }
            DP[t][n][p] = win ? 1 : -1;
        }
        return DP[t][n][p] == 1;
    }
    writeln(solve(0, N, P-1) ? "first" : "second");
}