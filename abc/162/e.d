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
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];

    auto cs = new long[](K+1);
    foreach_reverse (k; 1..K+1) {
        auto x = K / k;
        cs[k] = pow(x, N);
        auto kk = k;
        for (;;) {
            kk += k;
            if (kk > K) break;
            cs[k] = (cs[k] - cs[kk] + P) % P;
        }
    }
    long r;
    foreach (i, c; cs) r = (r + c * i.to!long % P) % P;
    writeln(r);
}