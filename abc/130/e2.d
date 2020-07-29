import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

long P = 10^^9+7;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto SS = readln.split.to!(int[]);
    auto TS = readln.split.to!(int[]);

    auto DP = new long[][](N+1, M+1);
    foreach (i; 1..N+1) {
        foreach (j; 1..M+1) {
            DP[i][j] = (DP[i][j-1] + DP[i-1][j] - DP[i-1][j-1] + P) % P;
            if (SS[i-1] == TS[j-1]) {
                (DP[i][j] += DP[i-1][j-1] + 1) %= P;
            }
        }
    }
    writeln((DP[N][M] + 1) % P);
}
