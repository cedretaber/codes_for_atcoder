import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmw = readln.split.to!(int[]);
    auto N = nmw[0];
    auto M = nmw[1];
    auto W = nmw[2];

    auto ws = new int[](N);
    auto vs = new int[](N);
    foreach (i; 0..N) {
        auto wv = readln.split.to!(int[]);
        ws[i] = wv[0];
        vs[i] = wv[1];
    }

    int[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        G[a] ~= b;
        G[b] ~= a;
    }

    int[] WS, VS;
    auto memo = new bool[](N);
    int[2] walk(int i, int p) {
        memo[i] = true;
        int w = ws[i], v = vs[i];
        foreach (j; G[i]) if (!memo[j]) {
            auto wv = walk(j, i);
            w += wv[0];
            v += wv[1];
        }
        return [w, v];
    }
    foreach (i; 0..N) if (!memo[i]) {
        auto wv = walk(i, -1);
        WS ~= wv[0];
        VS ~= wv[1];
    }

    auto n = WS.length;
    auto DP = new int[][](n, 10^^6);

    int solve(int i, int w) {
        if (i == n) return 0;
        if (DP[i][w]) return DP[i][w];
        if (w+WS[i] <= W) {
            DP[i][w] = max(solve(i+1, w), solve(i+1, w+WS[i]) + VS[i]);
        } else {
            DP[i][w] = solve(i+1, w);
        }
        return DP[i][w];
    }
    writeln(solve(0, 0));
}