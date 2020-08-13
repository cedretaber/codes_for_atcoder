import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias S = Tuple!(int, "x", int, "d");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    S[][] ss;
    foreach (i; 0..N) {
        S[] s;
        auto kk = readln.split.to!(int[]);
        auto k = kk[0];
        kk = kk[1..$];
        foreach (_; 0..k) {
            auto x = kk[0];
            auto d = kk[1];
            kk = kk[2..$];
            s ~= S(x, d);
        }
        ss ~= s;
    }

    auto DP = new int[][][](N, 10, M+1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max/3;
    foreach (j; 0..10) {
        DP[0][j][M] = 0;
        if (M) DP[1][j][M-1] = 0;
    }
    foreach (i; 0..N-1) {
        foreach (j, s; ss[i]) {
            foreach (k; 0..M+1) {
                if (i != 0 && DP[i][j][k] == int.max/3) continue;
                foreach (l, t; ss[i+1]) {
                    DP[i+1][l][k] = min(DP[i+1][l][k], DP[i][j][k] + (s.d + t.d) * abs(s.x - t.x));
                }
                if (k > 0 && i+2 < N) foreach (l, t; ss[i+2]) {
                    DP[i+2][l][k-1] = min(DP[i+2][l][k-1], DP[i][j][k] + (s.d + t.d) * abs(s.x - t.x));
                }
            }
        }
    }
    int r = int.max/3;
    foreach (j; 0..10) {
        r = min(r, DP[N-1][j][0]);
        foreach (k; 1..M+1) {
            r = min(r, DP[N-1][j][k], DP[N-2][j][k]);
        }
    }
    writeln(r);
}