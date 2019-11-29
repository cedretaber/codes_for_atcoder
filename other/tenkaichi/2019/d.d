import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;


enum P = 998244353L;
long[10^^5+50] F, RF;

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

long[300] AS;
long[][300] DP;

void main()
{
    init();
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) AS[i] = readln.chomp.to!long;
    long sum_a;
    foreach (a; AS[0..N]) sum_a += a;

    long r;
    foreach (a; 0..N+1) {
        foreach (b; 0..N+1) {
            auto c = N-(a+b);
            if (c < 0) continue;
            r = ((comb(N, a) * comb(N-a, b))%P + r)%P;
        }
    }
    writeln(r);
    foreach (ref dp; DP) dp.length = 300 * N + 1;
    foreach (i; 0..N) {
        foreach (t; 0..300*N+1) {
            if (!i) {
                if (t == 0) {
                    DP[i][t] = 2;
                } else if (t == AS[i]) {
                    DP[i][t] = 1;
                }
            } else {
                DP[i][t] = DP[i-1][t] * 2;
                if (t >= AS[i]) DP[i][t] = DP[i-1][t-AS[i]];
            }
        }
    }
    foreach (t; DP[N-1][(sum_a+1)/2..$]) {
        r -= t*6;
    }
    writeln(r);
}