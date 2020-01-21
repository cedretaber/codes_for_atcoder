import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

bool[10^^3+1] PS;
int[] QS;

void prime_init()
{
    PS[] = true;
    PS[0] = false;
    PS[1] = false;
    foreach (i; 2..10^^3+1) {
        if (PS[i]) {
            QS ~= i;
            auto x = i*2;
            while (x <= 10^^3) {
                PS[x] = false;
                x += i;
            }
        }
    }
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
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    prime_init();
    auto ps = new int[](10^^6+1);
    foreach (a; as) {
        int[int] qs;
        foreach (p; QS) {
            while (a%p == 0) {
                a /= p;
                if (p !in qs) qs[p] = 0;
                ++qs[p];
            }
        }
        if (a != 1) qs[a] = 1;
        foreach (p, n; qs) ps[p] = max(ps[p], n);
    }

    long x = 1;
    foreach (i, n; ps) if (n) {
        x = x * pow(i.to!long, n) % P;
    }
    long[] bs;
    long r;
    foreach (a; as) r = (r + x * inv(a) % P) % P;
    writeln(r);
}