import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum P = 10L^^9+7;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    long[] ps, ms;
    bool has_zero;
    foreach (a; readln.split.to!(long[])) {
        if (a == 0) has_zero = true;
        if (a < 0) {
            ms ~= -a;
        } else if (a > 0) {
            ps ~= a;
        }
    }
    if (ms.length + ps.length < K) {
        writeln(0);
        return;
    }
    sort!"a > b"(ps);
    sort!"a > b"(ms);

    if (ms.length == 0) {
        long r = 1;
        foreach (p; ps[0..K]) (r *= p) %= P;
        writeln(r);
        return;
    } else if (ps.length == 0) {
        long r = 1;
        if (K%2 == 0) {
            foreach (m; ms[0..K]) (r *= m) %= P;
            writeln(r);
        } else {
            if (has_zero) {
                writeln(0);
            } else {
                ms.reverse();
                foreach (m; ms[0..K]) (r *= m) %= P;
                writeln(P - r);
            }
        }
        return;
    }

    if (ps.length + ms.length == K) {
        long r = 1;
        foreach (p; ps) (r *= p) %= P;
        foreach (m; ms) (r *= m) %= P;
        if (ms.length%2 == 0) {
            writeln(r);
        } else {
            writeln(has_zero ? 0 : P - r);
        }
        return;
    }

    long p_max = 1;
    auto k = K;
    size_t i, j;
    while (k > 0) {
        if (k >= 2 && j+1 < ms.length && (i == ps.length || i+1 == ps.length || ps[i] * ps[i+1] < ms[j] * ms[j+1])) {
            (p_max *= ms[j++]) %= P;
            (p_max *= ms[j++]) %= P;
            k -= 2;
        } else {
            (p_max *= ps[i++]) %= P;
            k -= 1;
        }
    }
    writeln(p_max);
}