import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;


long P = 10^^9+7;
long[10^^6*2+10] F, RF;

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

void main()
{
    init();
    auto rc = readln.split.to!(long[]);
    auto r1 = rc[0];
    auto c1 = rc[1];
    auto r2 = rc[2];
    auto c2 = rc[3];

    long g(long r, long c) {
        long x;
        foreach (i; 1..r+2) {
            x = (x + F[i+c] * RF[i] % P * RF[c] % P) % P;
        }
        return x;
    }
    writeln( (((g(r2, c2) - g(r1-1, c2) + P) % P - g(r2, c1-1) + P) % P + g(r1-1, c1-1)) % P );
}