import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M1 = nm[1];
    auto M2 = nm[2];

    int[] as, bs, cs;
    foreach (_; 0..N) {
        auto abc = readln.split.to!(int[]);
        as ~= abc[0];
        bs ~= abc[1];
        cs ~= abc[2];
    }

    auto DP = new int[][][](N+1, 10*N+1, 10*N+1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max/3;
    DP[0][0][0] = 0;
    foreach (i; 0..N) {
        foreach (j; 0..10*N+1) {
            foreach (k; 0..10*N+1) {
                DP[i+1][j][k] = min(DP[i+1][j][k], DP[i][j][k]);
                auto jj = j + as[i];
                auto kk = k + bs[i];
                if (jj <= 10*N && kk <= 10*N) {
                    DP[i+1][jj][kk] = min(DP[i+1][jj][kk], DP[i][j][k] + cs[i]);
                }
            }
        }
    }
    auto r = int.max/3;
    foreach (j; 1..10*N+1) {
        foreach (k; 1..10*N+1) {
            if (j * M2 == k * M1) {
                r = min(r, DP[N][j][k]);
            }
        }
    }
    writeln(r == int.max/3 ? -1 : r);
}