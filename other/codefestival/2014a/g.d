import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    double[] ps;
    foreach (_; 0..N) ps ~= readln.chomp.to!double;

    auto DP = new double[][][](N+1, K+1, K+1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = 0;
    DP[1][1][1] = 1;

    foreach (i; 1..N) {
        foreach (j; 1..K) {
            foreach (k; 1..j+1) {
                auto p = ps[i] * 0.01;
                auto q = 1 - p;
                if (j == k) {
                    DP[i+1][j+1][k+1] += DP[i][j][k] * p;
                } else if (k+2 <= K) {
                    DP[i+1][j+1][k+2] += DP[i][j][k] * p;
                } else {
                    DP[i+1][j][k] += DP[i][j][k] * p;
                }
                if ((K-k) - (j-k)*2 >= 2) {
                    DP[i+1][j+1][k] += DP[i][j][k] * q;
                } else {
                    DP[i+1][j][k] += DP[i][j][k] * q;
                }
            }
        }
    }

    double r = 0;
    foreach (j; 0..K+1) {
        foreach (k; 0..K+1) {
            r += (K - j) * DP[N][j][k];
        }
    }

    writefln("%.12f", r);
}