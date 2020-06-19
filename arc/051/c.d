import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

enum P = 10L^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

alias I = Tuple!(int, "i", long, "n");

void main()
{
    auto nab = readln.split.to!(int[]);
    auto N = nab[0];
    long A = nab[1];
    long B = nab[2];
    auto as = readln.split.to!(long[]);

    if (A == 1) {
        sort(as);
        foreach (ref a; as) writeln(a % P);
        return;
    }

    auto fs = new bool[](N);
    I[] ii;
    foreach (i, a; as) ii ~= I(i.to!int, a);
    auto Q = heapify!"a.n > b.n"(ii);
    for (;;) {
        if (B == 0) break;
        foreach (f; fs) if (!f) goto ng;
        break;
        ng:

        --B;
        auto h = Q.front;
        Q.popFront();
        as[h.i] *= A;
        fs[h.i] = true;
        Q.insert(I(h.i, as[h.i]));
    }
    sort(as);

    auto b = B / N;
    auto d = B % N;
    foreach (i, ref a; as) a = a % P * pow(A, b + (i < d ? 1 : 0)) % P;
    if (d) as = as[d..$] ~ as[0..d];
    foreach (ref a; as) writeln(a);
}