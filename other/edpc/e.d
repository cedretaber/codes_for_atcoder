import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[100] WS, VS;

void main()
{
    auto nw = readln.split.to!(int[]);
    auto N = nw[0];
    auto W = nw[1];

    long[][] MEMO;
    MEMO.length = N;

    foreach (i; 0..N) {
        auto wv = readln.split.to!(long[]);
        WS[i] = wv[0];
        VS[i] = wv[1];
        MEMO[i].length = 10^^5+1;
    }

    long solve(int i, long v) {
        if (!v) return 0;
        if (i == N) return (long.max / 4) ;
        if (MEMO[i][v]) return MEMO[i][v];
        return MEMO[i][v] = min(
            solve(i+1, v),
            v < VS[i] ? (long.max / 4) : solve(i+1, v-VS[i]) + WS[i]
        );
    }

    foreach_reverse (v; 0..10^^5+1) {
        if (solve(0, v) <= W) {
            writeln(v);
            return;
        }
    }
}