import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 998244353L;
long[(10^^5)*2+50] F, RF;

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
    auto nmk = readln.split.to!(long[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];

    long r;
    foreach (k; N-1-K..N) {
        long x = comb(N-1, k);
        (x *= M) %= P;
        (x *= pow(M-1, k)) %= P;
        r = (r + x + P) % P;
    }
    writeln(r);
}