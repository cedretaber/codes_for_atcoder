import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
 
void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto HS = readln.split.to!(long[]);
    HS ~= 0;
    long[] hc;

    auto DP = new long[][](N, K+1);
    long solve(int i, int k) {
        if (i == N) return 0;
        if (DP[i][k] == 0) {
            long r = long.max;
            foreach (d; 1..k+2) {
                if (i+d > N) break;
                r = min(r, max(0, HS[i] - HS[i+d]) + solve(i+d, k-d+1));
            }
            DP[i][k] = r;
        }
        return DP[i][k];
    }
    long r = long.max;
    foreach (i; 0..min(N+1, K+1)) {
        r = min(r, solve(i, K-i));
    }
    writeln(r);
}