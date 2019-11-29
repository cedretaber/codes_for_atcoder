import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

void main()
{
    auto F = new long[](10^^6*2+10);
    auto RF = new long[](10^^6*2+10);

    long pow(long x, long n) {
        long y = 1;
        while (n) {
            if (n%2 == 1) y = (y * x) % P;
            x = x^^2 % P;
            n /= 2;
        }
        return y;
    }

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

    auto xy = readln.split.to!(long[]);
    auto X = xy[0];
    auto Y = xy[1];
    auto a = 2*X - Y;
    auto b = 2*Y - X;
    if (a < 0 || b < 0 || a%3 != 0 || b%3 != 0) {
        writeln(0);
        return;
    }
    a /= 3;
    b /= 3;

    if (a == 0 || b == 0) {
        writeln(1);
        return;
    }

    writeln(((F[a+b] * RF[a]) % P * RF[b]) % P);
}