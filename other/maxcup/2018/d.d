import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmlx = readln.split.to!(int[]);
    auto N = nmlx[0];
    auto M = nmlx[1];
    auto L = nmlx[2];
    auto X = nmlx[3];
    auto as = readln.split.to!(int[]);

    auto DP = new int[][](2, M);
    DP[0][] = int.max/3;
    DP[0][0] = 0;
    foreach (i; 0..N) {
        auto i1 = i%2;
        auto i2 = (i+1)%2;
        DP[i2][] = int.max/3;
        foreach (j; 0..M) {
            DP[i2][j] = min(DP[i2][j], DP[i1][j]);
            auto k = (j+as[i]) % M;
            if (j + as[i] >= M) {
                DP[i2][k] = min(DP[i2][k], DP[i1][j] + (j + as[i]) / M);
            } else {
                DP[i2][k] = min(DP[i2][k], DP[i1][j]);
            }
        }
    }
    writeln(DP[N%2][L] < X ? "Yes" : "No");
}