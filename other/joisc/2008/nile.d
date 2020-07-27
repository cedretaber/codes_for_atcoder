import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];

    auto ps = new int[][](D+2, N);
    foreach (i; 0..D) ps[i] = readln.split.to!(int[]);
    
    auto DP = new int[](D+2);
    DP[] = int.max;
    DP[0] = 0;
    foreach (i; 0..D) {
        foreach (j; 0..N) {
            auto p = DP[i] + ps[i][j];
            DP[i+1] = min(DP[i+1], p);
            p += ps[i+1][j]/10*9;
            DP[i+2] = min(DP[i+2], p);
            foreach (k; i+3..D+1) {
                p += ps[k-1][j]/10*7;
                DP[k] = min(DP[k], p);
            }
        }
    }
    writeln(DP[D]);
}