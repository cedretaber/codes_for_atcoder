import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;
long[10^^5*2+50] F, RF;

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

alias E = Tuple!(int, "i", long, "k", long, "p");

void main()
{
    init();
    auto N = readln.chomp.to!int;
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }

    E[][] es;
    es.length = N;
    E run1(int i, int p) {
        long pp = 1, k;
        foreach (j; T[i]) if (j != p) {
            auto e = run1(j, i);
            es[i] ~= e;
            pp = pp * inv(F[e.k]) % P * e.p % P;
            k += e.k;
        }
        return E(i, k + 1, pp * F[k] % P);
    }
    run1(0, -1);
    void run2(int i, int p, E e) {
        long pp = 1;
        if (p != -1) {
            pp = pp * inv(F[e.k]) % P * e.p % P;
        }
        foreach (ee; es[i]) {
            pp = pp * inv(F[ee.k]) % P * ee.p % P;
        }
        foreach (ee; es[i]) {
            run2(ee.i, i, E(i, N - ee.k, pp * F[N-ee.k-1] % P * F[ee.k] % P * inv(ee.p) % P));
        }
        if (p != -1) es[i] ~= e;
    }
    run2(0, -1, E(0, 0, 1));

    foreach (i; 0..N) {
        long r = F[N-1];
        foreach (e; es[i]) if (e.i != i) {
            r = r * inv(F[e.k]) % P * e.p % P;
        }
        writeln(r);
    }
}