import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

enum P = 998244353;

void main()
{
    auto ns = readln.split.to!(long[]);
    auto N = ns[0];
    auto S = ns[1];
    auto as = readln.split.to!(long[]);
    auto DP = new long[][](N, S+1);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int i, long s) {
        if (s == 0) {
            return N-i+1;
        } else if (s < 0 || i == N) {
            return 0;
        }
        if (DP[i][s] == -1) {
            DP[i][s] = (solve(i+1, s-as[i]) + solve(i+1, s)) % P;
        }
        return s == S ? 0 : DP[i][s];
    }
    solve(0, S);
    long r;
    foreach (i; 0..N) r = (r + (i+1) * DP[i][S]) % P;
    writeln(r);
}