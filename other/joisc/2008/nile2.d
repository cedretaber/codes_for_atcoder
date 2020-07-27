import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];

    auto ps = new int[][](D+2, N);
    foreach (i; 0..D) ps[i] = readln.split.to!(int[]);
    
    auto DP = new int[][][](2, N, 3);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max/3;
    foreach (d; 0..D) {
        auto i = d%2, ii = (d+1)%2;
        int min_p;
        if (d) {
            min_p = int.max;
            foreach (dp; DP[i]) foreach (p; dp) min_p = min(min_p, p);
        }
        foreach (j; 0..N) {
            DP[ii][j][0] = min_p + ps[d][j];
            DP[ii][j][1] = DP[i][j][0] + ps[d][j]/10*9;
            DP[ii][j][2] = min(DP[i][j][1], DP[i][j][2]) + ps[d][j]/10*7;
        }
    }
    auto min_p = int.max;
    foreach (ref dp; DP[D%2]) foreach (ref p; dp) min_p = min(min_p, p);
    writeln(min_p);
}