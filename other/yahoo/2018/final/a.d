import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, core.bitop;

Tuple!(N, N)[] prime_division(N)(N n)
{
    auto nn = n;
    Tuple!(N, N)[] res;
    for (N i = 2; i^^2 <= nn; ++i) {
        if (n%i == 0) {
            N cnt;
            while (n%i == 0) {
                ++cnt;
                n /= i;
            }
            res ~= tuple(i, cnt);
        }
    }
    if (n != cast(N)1) res ~= tuple(n, cast(N)1);
    return res;
}

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto cs = new int[](10^^5+1);
    foreach (_; 0..N) {
        auto a = readln.chomp.to!long;
        long[] ps;
        foreach (p; prime_division(a)) ps ~= p[0];
        foreach (x; 1..(1<<ps.length)) {
            int n = 1;
            foreach (i; 0..ps.length) if (x & (1<<i)) n *= ps[i];
            cs[n] += 1;
        }
    }
    foreach (m; 1..M+1) {
        long[] ps;
        foreach (p; prime_division(m)) ps ~= p[0];
        auto r = N;
        foreach (x; 1..(1<<ps.length)) {
            int n = 1;
            foreach (i; 0..ps.length) if (x & (1<<i)) n *= ps[i];
            r += cs[n] * (-1)^^popcnt(x);
        }
        writeln(r);
    }
}