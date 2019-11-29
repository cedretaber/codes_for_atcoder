import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;
long[10^^5*2+10] F, RF;

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
    auto nmk = readln.split.to!(long[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];

    long r;
    foreach (long d; 1..N) {
        auto x = (((N-d)*M^^2)%P*d)%P;
        if (K == 2) {
            r = (r+x)%P;
        } else {
            auto y = comb(N*M-2, K-2);
            r = (r + (x*y)%P)%P;
        }
    }
    foreach (long d; 1..M) {
        auto x = (((M-d)*N^^2)%P*d)%P;
        if (K == 2) {
            r = (r+x)%P;
        } else {
            auto y = comb(N*M-2, K-2);
            r = (r + (x*y)%P)%P;
        }
    }
    writeln(r);
}