import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto xy = readln.split.to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto N = readln.chomp.to!int;
    int[] ts;
    long[] hs;
    foreach (_; 0..N) {
        auto th = readln.split.to!(int[]);
        ts ~= th[0];
        hs ~= th[1];
    }

    auto DP = new long[][][](2, X+1, X+Y+1);
    foreach_reverse (i; 0..N) {
        foreach (n; 0..X+1) foreach (j; 0..X+Y+1) DP[i%2][n][j] = 0;
        foreach (n; 0..X+1) {
            foreach (j; 0..X+Y+1) {
                DP[i%2][n][j] = max(DP[i%2][n][j], DP[(i+1)%2][n][j]);
                auto jj = j+ts[i];
                if (n < X && jj <= X+Y) {
                    DP[i%2][n+1][jj] = max(DP[i%2][n+1][jj], DP[(i+1)%2][n][j] + hs[i]);
                }
            }
        }
    }
    long max_h;
    foreach (n; 1..X+1) foreach (t; 0..X+Y+1) max_h = max(max_h, DP[0][n][t]);
    writeln(max_h);
}