import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] vs, ts;
    foreach (_; 0..N) {
        auto vt = readln.split.to!(int[]);
        vs ~= vt[0];
        ts ~= vt[1];
    }
    auto DP = new int[][](2, M+1);
    foreach_reverse (i; 0..N) {
        foreach (m; 0..M+1) {
            DP[i%2][m] = max(
                DP[(i+1)%2][m],
                ts[i] <= m ? DP[(i+1)%2][m - ts[i]] + vs[i] : 0
            );
        }
    }
    writeln(DP[0][M]);
}