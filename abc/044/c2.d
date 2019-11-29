import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;
 
void main()
{
    auto na = readln.split.to!(int[]);
    auto N = na[0];
    auto A = na[1];
 
    auto XS = readln.split.to!(int[]);
 
    auto MEMO = new long[50*50+1][50+1][50+1];
    foreach (ref a; MEMO) {
        foreach (ref b; a) {
            foreach (ref c; b) c = -1;
        }
    }
    long solve(int i, int n, int s) {
        if (i == N) return n && s == n * A ? 1 : 0;
        if (MEMO[i][n][s] != -1) return MEMO[i][n][s];
        return MEMO[i][n][s] = solve(i+1, n+1, s+XS[i]) + solve(i+1, n, s);
    }
    writeln(solve(0, 0, 0));
}