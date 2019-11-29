import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10007;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);

    auto DP = new int[][](N, N, N);
    foreach (ref dp; DP) foreach (ref e; dp) e[] = -1;
    void solve(int i, int p, int r) {
        if (i == N) return r == 0 ? 1 : 0;
        if (DP[i][p][r] != -1) return DP[i][p][r];

        if (AS[i] == p || AS[i] == p+1) {
            
        }
    }
}