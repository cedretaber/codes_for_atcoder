import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nmyz = readln.split.to!(int[]);
    auto N = nmyz[0];
    auto M = nmyz[1];
    auto Y = nmyz[2];
    auto Z = nmyz[3];

    int[] ps;
    int[dchar] cs;

    foreach (i; 0..M) {
        auto cp = readln.split;
        auto c = cp[0][0].to!dchar;
        auto p = cp[1].to!int;
        cs[c] = i;
        ps ~= p;
    }

    auto bs = readln.chomp.to!(dchar[]).map!(c => cs[c]);

    auto DP = new int[][][](2, M+1, 1<<M);
    foreach (ref dp; DP[0]) dp[] = int.min/3;
    DP[0][M][0] = 0;
    foreach (i; 0..N) {
        auto i1 = i%2;
        auto i2 = (i+1)%2;
        auto b = bs[i];
        foreach (ref dp; DP[i2]) dp[] = int.min/3;
        foreach (j; 0..M+1) {
            foreach (k; 0..1<<M) {
                auto kk = k | (1<<b);
                DP[i2][b][kk] = max(DP[i2][b][kk], DP[i1][j][k] + ps[b] + (j == b ? Y : 0));
                DP[i2][j][k] = max(DP[i2][j][k], DP[i1][j][k]);
            }
        }
    }
    int max_p;
    foreach (j; 0..M+1) {
        foreach (k; 0..(1<<M)-1) max_p = max(max_p, DP[N%2][j][k]);
        max_p = max(max_p, DP[N%2][j][(1<<M)-1] + Z);
    }
    writeln(max_p);
}