import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ns = readln.split.to!(int[]);

    auto DP = new long[][](N, 21);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, int n) {
        if (i == N-1) return n == ns[$-1] ? 1 : 0;
        if (DP[i][n] == -1) {
            long r;
            if (n - ns[i] >= 0) r += solve(i+1, n-ns[i]);
            if (n + ns[i] <= 20) r += solve(i+1, n+ns[i]);
            DP[i][n] = r;
        }
        return DP[i][n];
    }
    writeln(solve(1, ns[0]));
}