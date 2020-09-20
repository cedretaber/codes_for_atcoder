import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import std.typecons : Tuple;

ulong safeMod(long x, long m) @safe pure nothrow @nogc
{
    x %= m;
    if (x < 0)
        x += m;
    return x;
}

long ctPowMod(long x, long n, int m) @safe pure nothrow @nogc
{
    if (m == 1)
        return 0;
    uint _m = cast(uint) m;
    ulong r = 1;
    ulong y = safeMod(x, m);
    while (n)
    {
        if (n & 1)
            r = (r * y) % _m;
        y = (y * y) % _m;
        n >>= 1;
    }
    return r;
}

bool ctIsPrime(int n) @safe pure nothrow @nogc
{
    if (n <= 1)
        return false;
    if (n == 2 || n == 7 || n == 61)
        return true;
    if (n % 2 == 0)
        return false;
    long d = n - 1;
    while (d % 2 == 0)
        d /= 2;
    foreach (a; [2, 7, 61])
    {
        long t = d;
        long y = ctPowMod(a, t, n);
        while (t != n - 1 && y != 1 && y != n - 1)
        {
            y = y * y % n;
            t <<= 1;
        }
        if (y != n - 1 && t % 2 == 0)
        {
            return false;
        }
    }
    return true;
}

enum bool isPrime(int n) = ctIsPrime(n);

Tuple!(long, long) invGcd(long a, long b) @safe pure nothrow @nogc
{
    a = safeMod(a, b);
    if (a == 0)
        return Tuple!(long, long)(b, 0);
    long s = b, t = a, m0 = 0, m1 = 1;
    while (t)
    {
        long u = s / t;
        s -= t * u;
        m0 -= m1 * u;
        long tmp = s;
        s = t;
        t = tmp;
        tmp = m0;
        m0 = m1;
        m1 = tmp;
    }
    if (m0 < 0)
        m0 += b / s;
    return Tuple!(long, long)(s, m0);
}

int ctPrimitiveRoot(int m) @safe pure nothrow @nogc
{
    if (m == 2)
        return 1;
    if (m == 167_772_161)
        return 3;
    if (m == 469_762_049)
        return 3;
    if (m == 754_974_721)
        return 11;
    if (m == 998_244_353)
        return 3;
    int[20] divs;
    divs[0] = 2;
    int cnt = 1;
    int x = (m - 1) / 2;
    while (x % 2 == 0)
        x /= 2;
    for (int i = 3; (cast(long) i) * i <= x; i += 2)
        if (x % i == 0)
        {
            divs[cnt++] = i;
            while (x % i == 0)
                x /= i;
        }
    if (x > 1)
        divs[cnt++] = x;
    for (int g = 2;; g++)
    {
        bool ok = true;
        foreach (i; 0 .. cnt)
            if (ctPowMod(g, (m - 1) / divs[i], m) == 1)
            {
                ok = false;
                break;
            }
        if (ok)
            return g;
    }
}

enum primitiveRoot(int m) = ctPrimitiveRoot(m);

long powMod(long x, long n, long m) @safe pure nothrow @nogc
{
    assert(0 <= n && 1 <= m);
    if (m == 1)
        return 0;
    ulong r = 1, y = safeMod(x, m);
    while (n)
    {
        if (n & 1)
            r = (r * y) % m;
        y = (y * y) % m;
        n >>= 1;
    }
    return r;
}

long invMod(long x, long m) @safe pure nothrow @nogc
{
    assert(1 <= m);
    auto z = invGcd(x, m);
    assert(z[0] == 1);
    return z[1];
}

Tuple!(long, long) crt(long[] r, long[] m) @safe pure nothrow @nogc
{
    assert(r.length == m.length);
    long r0 = 0, m0 = 1;
    foreach (i; 0 .. r.length)
    {
        assert(1 <= m[i]);
        long r1 = safeMod(r[i], m[i]);
        long m1 = m[i];
        if (m0 < m1)
        {
            auto tmp = r0;
            r0 = r1;
            r1 = tmp;
            tmp = m0;
            m0 = m1;
            m1 = tmp;
        }
        if (m0 % m1 == 0)
        {
            if (r0 % m1 != r1)
                return Tuple!(long, long)(0, 0);
            continue;
        }
        long g, im;
        {
            auto tmp = invGcd(m0, m1);
            g = tmp[0];
            im = tmp[1];
        }
        long u1 = m1 / g;
        if ((r1 - r0) % g)
            return Tuple!(long, long)(0, 0);
        long x = (r1 - r0) / g % u1 * im % u1;
        r0 += x * m0;
        m0 *= u1;
        if (r0 < 0)
            r0 += m0;
    }
    return Tuple!(long, long)(r0, m0);
}

long floorSum(long n, long m, long a, long b) @safe pure nothrow @nogc
{
    long ans;
    if (m <= a)
    {
        ans += (n - 1) * n * (a / m) / 2;
        a %= m;
    }
    if (m <= b)
    {
        ans += n * (b / m);
        b %= m;
    }
    long y_max = (a * n + b) / m, x_max = (y_max * m - b);
    if (y_max == 0)
        return ans;
    ans += (n - (x_max + a - 1) / a) * y_max;
    ans += floorSum(y_max, a, m, (a - x_max % a) % a);
    return ans;
}

void main()
{
    auto N = readln.chomp.to!long * 2;
    long[] ps;
    for (long p = 1; p^^2 <= N; ++p) if (N%p == 0) {
        ps ~= p;
        if (N/p != p) ps ~= N/p;
    }
    long res = long.max;
    foreach (p; ps) {
        auto ret = crt([0, -1], [p, N/p]);
        if (ret[0]) res = min(res, ret[0]);
    }
    writeln(res == long.max ? N : res);
}

/*

k * (k+1) / 2 = 0 mod N

k = N*2
N*2 * (N*2+1) / 2 mod N = 0

k(k+1) = 2aN

k と 2N の共通の約数を x と置く。
xb = k
xc = 2N
2N / x = (k+1)d

xを固定し、 y = 2N/x と置く。
k = 0 mod x
k = -1 mod y -> k+1 が 0 なので、 k は -1

x は 2N の約数の1つなので、これを探索すれば良い。

*/