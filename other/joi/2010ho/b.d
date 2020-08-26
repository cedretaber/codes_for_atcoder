import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    int[] ts;
    foreach (_; 1..N) ts ~= readln.chomp.to!int;
    ts ~= 0;
    auto DP = new int[][][](2, N/2+1, 2);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max/3;
    DP[0][0][0] = 0;
    DP[0][0][1] = 0;
    foreach (ii; 0..N) {
        auto i = ii%2;
        auto j = (ii+1)%2;
        foreach (ref dp; DP[j]) dp[] = int.max/3;
        foreach (k; 0..N/2+1) {
            if (k < N/2) {
                DP[j][k+1][0] = min(DP[j][k+1][0], DP[i][k][0]);
                DP[j][k+1][1] = min(DP[j][k+1][1], DP[i][k][0] + ts[ii]);
            }
            DP[j][k][0] = min(DP[j][k][0], DP[i][k][1] + ts[ii]);
            DP[j][k][1] = min(DP[j][k][1], DP[i][k][1]);
        }
    }
    writeln(min(DP[N%2][N/2][0], DP[N%2][N/2][1]));
}