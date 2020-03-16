import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;


long P = 10^^9+7;
long[10^^6*2+50] F, RF;

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

/**
  * P を法とする階乗、逆元を予め計算しておく。
  */
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
    auto xy = readln.split.to!(int[]);
    auto X = xy[0];
    auto Y = xy[1];
    foreach (i; 0..10^^6) {
        auto x = X - i*2;
        auto y = Y - i;
        if (x < 0 || y < 0 || x*2 != y) continue;
        auto j = y/2;
        writeln(F[i+j] * RF[i] % P * RF[j] % P);
        return;
    }
    writeln(0);
}