import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "i", int, "r", int, "c");

void main()
{
    auto mr = readln.split.to!(int[]);
    auto M = mr[0];
    auto R = mr[1];

    auto G = [
        [1],
        [0, 2, 4],
        [1, 3, 5],
        [2, 6],
        [1, 5, 7],
        [2, 4, 6, 8],
        [3, 5, 9],
        [4, 8],
        [5, 7, 9],
        [6, 8]
    ];

    auto DP = new bool[][](10, M);

    auto ss = [P(0, 0, 0)];
    DP[0][0] = true;
    for (;;) {
        auto p = ss[0];
        ss = ss[1..$];
        {
            auto r = (p.r*10 + p.i) % M;
            if (r == R) {
                writeln(p.c + 1);
                return;
            }
            if (!DP[p.i][r]) {
                DP[p.i][r] = true;
                ss ~= P(p.i, r, p.c + 1);
            }
        }
        foreach (n; G[p.i]) {
            if (DP[n][p.r]) continue;
            DP[n][p.r] = true;
            ss ~= P(n, p.r, p.c + 1);
        }
    }
}