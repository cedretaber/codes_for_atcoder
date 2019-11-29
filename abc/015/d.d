import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(int, "a", int, "b");

AB[50] ABS;

void main()
{
    auto W = readln.chomp.to!int;
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        ABS[i] = AB(ab[0], ab[1]);
    }
    int[][][] DP;
    DP.length = N;
    foreach (ref dp; DP) {
        dp.length = K+1;
        foreach (ref d; dp) {
            d.length = N*100+1;
            foreach (ref e; d) e = W+1;
        }
    }
    foreach (n; 0..N) {
        foreach (k; 0..K+1) {
            foreach (b; 0..N*100+1) {
                if (n == 0) {
                    if (b == 0) DP[n][k][b] = 0;
                    if (k == 1 && b == ABS[n].b) DP[n][k][b] = ABS[n].a;
                } else {
                    if (b+ABS[n].b < N*100+1 && k < K) {
                        DP[n][k+1][b+ABS[n].b] = DP[n-1][k][b] + ABS[n].a;
                    }
                    DP[n][k][b] = min(DP[n][k][b], DP[n-1][k][b]);
                }
            }
        }
    }
    int r;
    foreach (n; 0..N) {
        foreach (k; 0..K+1) {
            foreach (b; 0..N*100+1) {
                if (DP[n][k][b] <= W) r = max(r, b);
            }
        }
    }
    writeln(r);
}