import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

long P = 10^^9+7;
long[10^^5*2+50] F, RF;

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

Tuple!(N, N)[] prime_division(N)(N n)
{
    auto nn = n;
    Tuple!(N, N)[] res;
    for (N i = 2; i^^2 <= nn; ++i) {
        if (n%i == 0) {
            N cnt;
            while (n%i == 0) {
                ++cnt;
                n /= i;
            }
            res ~= tuple(i, cnt);
        }
    }
    if (n != cast(N)1) res ~= tuple(n, cast(N)1);
    return res;
}

void main()
{
    init();
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    long r;
    foreach (i; 0..M+1) if ((i%2 == 0 && N > 0) || (i%2 == 1 && N < 0)) {
        (r += comb(M, i)) %= P;
    }
    foreach (p; prime_division(abs(N))) {
        (r *= comb(M+p[1]-1, M-1)) %= P;
    }
    writeln(r);
}