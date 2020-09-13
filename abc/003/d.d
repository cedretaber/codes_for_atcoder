import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

long P = 10^^9+7;
long[10^^5+50] F, RF;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long inv(long x)
{
    return pow(x, P-2);
}

void init()
{
    F[0] = F[1] = 1;
    foreach (i, ref x; F[2..$]) x = (F[i+1] * (i+2)) % P;

    {
        RF[$-1] = 1;
        auto x = F[$-1];
        auto k = P-2;
        while (k) {
            if (k%2 == 1) RF[$-1] = (RF[$-1] * x) % P;
            x = x^^2 % P;
            k /= 2;
        }
    }
    foreach_reverse(i, ref x; RF[0..$-1]) x = (RF[i+1] * (i+1)) % P;
}

long comb(N)(N n, N k)
{
    if (k > n) return 0;
    auto n_b = F[n];    // n!
    auto nk_b = RF[n-k]; // 1 / (n-k)!
    auto k_b = RF[k];    // 1 / k!

    auto nk_b_k_b = (nk_b * k_b) % P; // 1 / (n-k)!k!

    return (n_b * nk_b_k_b) % P;  // n! / (n-k)!k!
}

void main()
{
    init();
    auto rc = readln.split.to!(long[]);
    auto R = rc[0];
    auto C = rc[1];
    auto xy = readln.split.to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto dl = readln.split.to!(long[]);
    auto D = dl[0];
    auto L = dl[1];

    auto s = X*Y;
    auto d = comb(s, D);
    auto l = comb(s-D, L);
    auto m = d * l % P;

    foreach (b; 1..2^^4) {
        auto x = X, y = Y;
        if (b&1) --x;
        if (b&2) --x;
        if (b&4) --y;
        if (b&8) --y;
        s = x * y;
        d = comb(s, D);
        l = 0;
        if (s-D > 0) l = comb(s-D, L);
        (m += d * l % P * (popcnt(b)%2 == 1 ? -1 : 1) + P) %= P;
    }

    auto n = (R-X+1) * (C-Y+1);
    writeln((m * n) % P);
}