import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] VS = [0], WS = [0];
    foreach (_; 0..N) {
        auto vw = readln.split.to!(int[]);
        VS ~= vw[0];
        WS ~= vw[1];
    }
    auto Q = readln.chomp.to!int;

    auto len = min(2^^9+1, N+1);
    auto MAX_L = 10^^5;
    auto DP = new int[][](len, MAX_L+1);
    foreach (i; 1..len) {
        foreach (w; 0..MAX_L+1) {
            DP[i][w] = max(DP[i][w], DP[i/2][w]);
            if (w - WS[i] >= 0) DP[i][w] = max(DP[i][w], DP[i/2][w-WS[i]] + VS[i]);
        }
    }

    foreach (_; 0..Q) {
        auto vl = readln.split.to!(int[]);
        auto v = vl[0];
        auto L = vl[1];

        if (v < len) {
            writeln(DP[v][L]);
        } else {
            int solve(int i, int l) {
                if (i < len) return DP[i][l];
                auto r1 = solve(i/2, l);
                int r2;
                if (l - WS[i] >= 0) r2 = solve(i/2, l - WS[i]) + VS[i];
                return max(r1, r2);
            }
            writeln(solve(v, L));
        }
    }
}