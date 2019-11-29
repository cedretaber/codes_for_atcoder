import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

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

long[10^^4] TS;

void main()
{
    init();
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) TS[i] = readln.chomp.to!long;
    sort(TS[0..N]);
    long r, t;
    int[long] CNT;
    foreach (i; 0..N) {
        if (TS[i] !in CNT) CNT[TS[i]] = 0;
        ++CNT[TS[i]];
        t += TS[i];
        r += t;
    }
    long v = 1;
    foreach (_, c; CNT) {
        v = (v * F[c]) % P;
    }

    writeln(r);
    writeln(v);
}