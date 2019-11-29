import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    long[][] DP, SUM;
    DP.length = N+1;
    SUM.length = N+1;
    foreach (i; 0..N+1) {
        DP[i].length = M+1;
        SUM[i].length = M+1;
    }
    auto SS = readln.split.to!(long[]);
    auto TS = readln.split.to!(long[]);

    DP[0][0] = 1;
    foreach (i; 0..N+1) {
        foreach (j; 0..M+1) {
            if (i > 0 && j > 0 && SS[i-1] == TS[j-1]) {
                DP[i][j] = SUM[i-1][j-1];
            }
            SUM[i][j] = DP[i][j];
            if (i > 0) SUM[i][j] += SUM[i-1][j];
            if (j > 0) SUM[i][j] += SUM[i][j-1];
            if (i > 0 && j > 0) SUM[i][j] += P - SUM[i-1][j-1];
            SUM[i][j] %= P;
        }
    }

    writeln(SUM[N][M]);
}