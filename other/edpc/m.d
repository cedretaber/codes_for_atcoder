import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9 + 7;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto as = readln.split.to!(int[]);

    long[][] DP;
    DP.length = N;
    foreach_reverse (i, ref dp; DP) {
        dp.length = K+1;
        long[] cs;
        if (i+1 != N) {
            cs.length = K+1;
            cs[0] = DP[i+1][0];
            foreach (k; 1..K+1) cs[k] = (DP[i+1][k] + cs[k-1]); 
        }
        foreach (j; 0..K+1) {
            DP[i][j] = i+1 == N ? (j <= as[i] ? 1 : 0) : (j <= as[i] ? cs[j] : cs[j] - cs[j - as[i] - 1]) % P;
        }
    }

    writeln(DP[0][K]);
}