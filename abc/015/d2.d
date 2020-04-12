import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto W = readln.chomp.to!int;
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[] as, bs;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        as ~= ab[0];
        bs ~= ab[1];
    }
    auto DP = new int[][][](N+1, K+1, 100*N+1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = int.max/3;
    DP[0][0][0] = 0;
    foreach (i; 0..N) {
        foreach (k; 0..K+1) {
            foreach (b; 0..100*N+1) {
                DP[i+1][k][b] = min(DP[i+1][k][b], DP[i][k][b]);
                if (k < K && DP[i][k][b] + as[i] <= W) DP[i+1][k+1][b + bs[i]] = min(DP[i+1][k+1][b + bs[i]], DP[i][k][b] + as[i]);
            }
        }
    }
    int r;
    foreach (k; 0..K+1) foreach (b; 0..100*N+1) if (DP[N][k][b] <= W) r = max(r, b);
    writeln(r);
}