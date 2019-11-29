import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;
long[10^^5+50] F, RF;

void init()
{
    F[1] = 1;
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

int[2][] prime_division(int m)
{
    int[2][] r;
    for (int x = 2; x^^2 <= m; ++x) {
        int cnt;
        while (m % x == 0) {
            ++cnt;
            m /= x;
        }
        if (cnt) r ~= [x, cnt];
    }
    if (m != 1) r ~= [m, 1];
    return r;
}

void main()
{
    init();
    auto nm = readln.split.to!(int[]);
    long N = nm[0];
    auto M = nm[1];

    long r = 1;
    foreach (p; prime_division(M)) {
        r = (r * comb(N+p[1]-1, p[1])) % P;
    }
    writeln(r);
}