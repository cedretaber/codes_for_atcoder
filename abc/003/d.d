import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;


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
    auto x = (d*l) % P;
    auto t = s - (X-1)*2 - (Y-1)*2;
    d = comb(t, D);
    l = 0;
    if (t-D > 0) l = comb(t-D, L);
    auto y = (d*l) % P;
    auto z = (x-y+P) % P;
    auto n = (R-X+1) * (C-Y+1);
    
    writeln((z * n) % P);
}