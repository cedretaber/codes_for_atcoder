import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    auto dftn = readln.split.to!(int[]);
    auto D = dftn[0];
    auto F = dftn[1];
    auto T = dftn[2];
    auto N = dftn[3];
    auto xs = readln.split.to!(int[]);
    xs ~= D;

    auto DP = new long[](N+1);
    auto fs = new bool[](N+1);
    long solve(int i, long r) {
        auto d = i == 0 ? xs[0] : xs[i] - xs[i-1];
        if (r-d < 0) return 0;
        if (i == N) return 1;

        long j = 1;
        ++i;
        while (r-d >= T && i >= N) {
            d += xs[i] - xs[i-1];
            ++j; ++i;
        }
        if (i == N+1) return pow(2, j);

        if (!fs[i]) {
            fs[i] = true;
            DP[i] = pow(solve(i, F), j);
        }
        return (DP[i] + (pow(solve(i, r-d), j))) % P;
    }
    writeln(solve(0, F));
}