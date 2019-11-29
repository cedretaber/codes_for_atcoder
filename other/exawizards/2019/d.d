import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

long P = 10^^9+7;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    auto X = nx[1];
    auto SS = readln.split.to!(int[]);
    sort!"a > b"(SS);

    long[][] DP;
    DP.length = 201;
    foreach (ref dp; DP) dp.length = 10^^5+1;
    DP[0][X] = 1;

    foreach (i; 0..N) {
        foreach (long x; 0..10^^5+1) {
            DP[i+1][x] = (DP[i+1][x] + DP[i][x] * (N-i-1)) % P;
            DP[i+1][x%SS[i]] = (DP[i+1][x%SS[i]] + DP[i][x]) % P;
        }
    }

    long r;
    foreach (long x; 0..10^^5+1) {
        r = (r + x * DP[N][x]) % P;
    }
    writeln(r);
}