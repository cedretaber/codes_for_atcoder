import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nts = readln.split.to!(int[]);
    auto N = nts[0];
    auto T = nts[1];
    auto S = nts[2];

    int[] AS, BS;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        AS ~= ab[0];
        BS ~= ab[1];
    }

    auto DP = new int[][](T+1, N+1);
    foreach (t; 0..T) {
        foreach (i; 0..N) {
            DP[t][i+1] = max(DP[t][i+1], DP[t][i]);

            auto u = t + BS[i];
            if (u > T) continue;
            if (u <= S || S <= t) {
                DP[u][i+1] = max(DP[u][i+1], DP[t][i] + AS[i]);
                if (u <= S) {
                    DP[S][i+1] = max(DP[S][i+1], DP[t][i] + AS[i]);
                }
            }
        }
    }

    writeln(DP[].map!(l => l.maxElement).maxElement);
}