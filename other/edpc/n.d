import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    auto cs = new long[](N);
    foreach (i; 0..N) {
        if (i != 0) cs[i] = cs[i-1];
        cs[i] += as[i];
    }

    auto DP = new long[][](N, N);
    long solve(int l, int r) {
        if (l == r) return 0;
        if (DP[l][r] == 0) {
            long x = long.max;
            foreach (m; l..r) {
                x = min(x, solve(l, m) + solve(m+1, r));
            }
            x += cs[r];
            if (l != 0) x -= cs[l-1];
            DP[l][r] = x;
        }
        return DP[l][r];
    }
    writeln(solve(0, N-1));
}