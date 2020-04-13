import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto DP = new int[][][](101, 101, 101);
    foreach (_; 0..N) {
        auto xw = readln.split.to!(int[]);
        auto x = xw[0];
        auto y = xw[1];
        auto z = xw[2];
        auto w = xw[3];
        DP[x][y][z] = max(DP[x][y][z], w);
    }
    foreach (i; 0..101) {
        foreach (j; 0..101) {
            foreach (k; 0..101) {
                DP[i][j][k] = max(
                    DP[i][j][k],
                    i > 0 ? DP[i-1][j][k] : 0,
                    j > 0 ? DP[i][j-1][k] : 0,
                    k > 0 ? DP[i][j][k-1] : 0
                );
            }
        }
    }
    foreach (_; 0..M) {
        auto s = readln.split.to!(int[]);
        writeln(DP[s[0]][s[1]][s[2]]);
    }
}