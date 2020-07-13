import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

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

N[] all_divisors(N)(N n)
{

    auto ps = prime_division(n);
    N[] ds;
    void run(int i, N x) {
        if (i == ps.length) {
            ds ~= x;
        } else {
            foreach (j; 0..ps[i][1]+1) run(i+1, x * ps[i][0]^^j);
        }
    }
    run(0, 1);
    return ds;
}

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    long[] AS;
    long s;
    foreach (a; readln.split.to!(long[])) {
        AS ~= a;
        s += a;
    }
    auto ds = all_divisors(s);
    sort!"a > b"(ds);

    bool check(long d) {
        long[] ds;
        foreach (a; AS) if (a != d) ds ~= a%d;
        if (ds.empty) return true;

        sort(ds);
        size_t i, j = ds.length-1;
        int k;
        while (i < j) {
            auto r = ds[i++]%d;
            k += r;
            while (r) {
                auto b = ds[j];
                ds[j] += r;
                r = 0;
                if (ds[j]/d > b/d) {
                    r = ds[j]%d;
                    --j;
                }
            }
        }
        return k <= K;
    }
    foreach (d; ds) if (check(d)) {
        writeln(d);
        return;
    }
}