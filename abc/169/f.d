import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 998244353L;

void main()
{
    auto ns = readln.split.to!(int[]);
    auto N = ns[0];
    auto S = ns[1];
    auto AS = readln.split.to!(int[]);

    auto DP = new long[][](N+1, S+1);
    DP[0][0] = 1;

    foreach (i; 0..N) {
        foreach (j; 0..S+1) {
            (DP[i+1][j] += DP[i][j] * 2) %= P;
            if (j + AS[i] <= S) (DP[i+1][j+AS[i]] += DP[i][j]) %= P;
        }
    }

    writeln(DP[N][S]);
}