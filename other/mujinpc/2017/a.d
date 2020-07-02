import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

long P = 10^^9+7;
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

void main()
{
    init();
    auto N = readln.chomp.to!long;
    auto r = F[N];
    long d = 1, p = 1, c = 1;
    foreach (i, x; readln.split.to!(long[])) {
        if (x < d) {
            r = (r - p * (N-i-1) % P * F[N-c] % P + P) % P;
            d -= 2;
            p = p * (i+2-c) % P;
            ++c;
        }
        d += 2;
    }
    writeln(r);
}