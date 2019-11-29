import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[100] WS, VS;

void main()
{
    auto nw = readln.split.to!(int[]);
    auto N = nw[0];
    auto W = nw[1];

    long[][] MEMO;
    MEMO.length = N;

    foreach (i; 0..N) {
        auto wv = readln.split.to!(int[]);
        WS[i] = wv[0];
        VS[i] = wv[1];
        MEMO[i].length = 10^^5+1;
    }

    long solve(int i, int w) {
        if (i == N) return 0;
        if (MEMO[i][w]) return MEMO[i][w];
        return MEMO[i][w] = max(
            solve(i+1, w),
            w >= WS[i] ? solve(i+1, w - WS[i]) + VS[i] : 0
        );
    }

    writeln(solve(0, W));
}