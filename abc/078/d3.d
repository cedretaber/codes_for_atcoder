import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nzw = readln.split.to!(int[]);
    auto N = nzw[0];
    auto Z = nzw[1];
    auto W = nzw[2];
    auto as = readln.split.to!(int[]).reverse.array;

    auto DP = new int[][](2, N+1);
    foreach (ref dp; DP) dp[] = -1;
    int solve(int t, int i) {
        auto a = i == N ? W : as[i];
        if (DP[t][i] == -1) {
            auto r = abs(a - as[0]);
            foreach (j; 1..i) {
                r = t == 0 ? max(r, solve(1, j)) : min(r, solve(0, j));
            }
            DP[t][i] = r;
        }
        return DP[t][i];
    }
    writeln(solve(0, N));
}