import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10000L;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto ks = new int[](100);
    foreach (_; 0..K) {
        auto ab = readln.split.to!(int[]);
        ks[ab[0]-1] = ab[1];
    }
    auto DP = new int[][][](100, 4, 4);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = -1;
    int solve(int i, int p1, int p2) {
        if (i == N) return 1;
        if (DP[i][p1][p2] == -1) {
            int r;
            if (ks[i] == 0) {
                foreach (p3; 1..4) if (p1 != p2 || p2 != p3) {
                    r = (r + solve(i+1, p2, p3)) % P;
                }
            } else {
                if (p1 == p2 && p2 == ks[i]) {
                    r = 0;
                } else {
                    r = solve(i+1, p2, ks[i]);
                }
            }
            DP[i][p1][p2] = r;
        }
        return DP[i][p1][p2];
    }
    writeln(solve(0, 0, 0));
}