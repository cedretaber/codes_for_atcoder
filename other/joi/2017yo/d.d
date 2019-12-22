import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ds = new int[](N);
    auto cs = new int[][](N, M);
    foreach (i; 0..N) {
        if (i) {
            foreach (j; 0..M) cs[i][j] = cs[i-1][j]; 
        }
        auto d = readln.chomp.to!int;
        ds[i] = d;
        ++cs[i][d-1];
    }

    auto DP = new int[](1<<M);
    DP[] = -1;
    int solve(uint s) {
        if (s == (1<<M)-1) return 0;
        if (DP[s] != -1) return DP[s];
        int x;
        foreach (i; 0..M) if (s & (1<<i)) x += cs[N-1][i];
        auto r = int.max;
        foreach (i; 0..M) if (!(s & (1<<i))) {
            int n = cs[x + cs[N-1][i] - 1][i];
            if (x) n -= cs[x-1][i];
            r = min(r, solve(s | (1<<i)) + cs[N-1][i] - n);
        }
        return DP[s] = r;
    }
    writeln(solve(0));
}