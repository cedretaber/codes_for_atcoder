import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] ns;
    auto cs = new int[](M);
    auto ds = new int[][](N+1, M);
    foreach (i; 0..N) {
        auto n = readln.chomp.to!int-1;
        ns ~= n;
        ++cs[n];
        if (i) foreach (j; 0..M) ds[i+1][j] = ds[i][j];
        ++ds[i+1][n];
    }

    auto DP = new int[](1<<M);
    DP[] = -1;
    int solve(uint s) {
        if (s == (1<<M)-1) return 0;

        if (DP[s] == -1) {
            int i, r = int.max/3;
            foreach (x; 0..M) if (s & (1<<x)) i += cs[x];
            foreach (x; 0..M) if ((s | (1<<x)) != s) {
                auto j = i + cs[x];
                r = min(r, solve(s | (1<<x)) + cs[x] - ds[j][x] + ds[i][x]);
            }
            DP[s] = r;
        }
        return DP[s];
    }

    writeln(solve(0));
}