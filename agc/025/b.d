import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

long P = 998244353L;

long[10^^5*3+50] F, RF;

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
    auto n_b = F[n];    // n!
    auto nk_b = RF[n-k]; // 1 / (n-k)!
    auto k_b = RF[k];    // 1 / k!

    auto nk_b_k_b = (nk_b * k_b) % P; // 1 / (n-k)!k!

    return (n_b * nk_b_k_b) % P;  // n! / (n-k)!k!
}

void main()
{
    init();

    auto nabk = readln.split.to!(long[]);
    auto N = nabk[0];
    auto A = nabk[1];
    auto B = nabk[2];
    auto K = nabk[3];

    long r;
    foreach (i; 0..N+1) {
        auto l = K-A*i;
        auto j = l/B;
        if (l%B != 0 || j > N || j < 0) continue;

        auto s = (comb(N, i) * comb(N, j)) % P;
        r = (r + s) % P;
    }

    writeln(r);
}