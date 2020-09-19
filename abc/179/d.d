import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 998244353L;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[] LS, RS;
    foreach (_; 0..K) {
        auto lr = readln.split.to!(int[]);
        LS ~= lr[0];
        RS ~= lr[1];
    }

    auto DP = new long[](N+1);
    DP[1] = 1;
    DP[2] = P - 1;
    foreach (i; 1..N+1) {
        (DP[i] += DP[i-1]) %= P;
        foreach (j; 0..K) {
            auto l = LS[j];
            auto r = RS[j]+1;
            if (i+l <= N) (DP[i+l] += DP[i]) %= P;
            if (i+r <= N) (DP[i+r] += P - DP[i]) %= P;
        }
    }
    writeln(DP[N]);
}