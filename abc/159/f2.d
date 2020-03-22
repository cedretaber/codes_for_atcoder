import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

enum P = 998244353;

void main()
{
    auto ns = readln.split.to!(long[]);
    auto N = ns[0];
    auto S = ns[1];
    auto as = readln.split.to!(long[]);
    auto DP = new long[][][](N+1, S+1, 2);
    foreach (i; 0..N) {
        if (as[i] < S) {
            DP[i+1][as[i]][0] = i+1;
        } else if (as[i] == S) {
            DP[i+1][S][1] = ((i+1) * (N-i)) % P;
        }
        foreach (s; 0..S) {
            DP[i+1][s][0] = (DP[i+1][s][0] + DP[i][s][0]) % P;
            if (as[i] + s < S) {
                DP[i+1][as[i] + s][0] = (DP[i+1][as[i] + s][0] + DP[i][s][0]) % P;
            } else if (as[i] + s == S) {
                DP[i+1][S][1] = (DP[i+1][S][1] + DP[i][s][0] * (N-i)) % P;
            }
        }
        DP[i+1][S][1] = (DP[i+1][S][1] + DP[i][S][1]) % P;
    }
    writeln(DP[N][S][1]);
}