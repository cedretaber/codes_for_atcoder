import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nxm = readln.split.to!(long[]);
    auto N = nxm[0];
    auto X = nxm[1];
    auto M = nxm[2];

    long res;
    long[] DP;
    long[long] MEMO;
    foreach (i; 0..N) {
        if (X == 0) {
            writeln(res);
            return;
        }
        if (X in MEMO) {
            auto s = MEMO[X];
            DP = DP[s..$];
            foreach (j; 1..DP.length) DP[j] += DP[j-1];
            auto rr = N - i;
            auto d = rr / DP.length;
            res += DP[$-1] * d;
            if (rr % DP.length != 0) {
                res += DP[rr % DP.length - 1];
            }
            writeln(res);
            return;
        }
        DP ~= X;
        MEMO[X] = i;
        res += X;
        X = X^^2 % M;
    }
    writeln(res);
}