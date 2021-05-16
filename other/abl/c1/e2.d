import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

import std.typecons : Tuple;

/// Return: `x mod m`
/// Param: `1 <= m`
ulong safeMod(long x, long m) @safe pure nothrow @nogc
{
    x %= m;
    if (x < 0)
        x += m;
    return x;
}

/// Return: `a*b` (128bit width)
ulong[2] umul128(ulong a, ulong b) @safe @nogc pure nothrow
{
    immutable ulong au = a >> 32;
    immutable ulong bu = b >> 32;
    immutable ulong al = a & ((1UL << 32) - 1);
    immutable ulong bl = b & ((1UL << 32) - 1);

    ulong t = al * bl;
    immutable ulong w3 = t & ((1UL << 32) - 1);
    ulong k = t >> 32;
    t = au * bl + k;

    k = t & ((1UL << 32) - 1);
    immutable ulong w1 = t >> 32;
    t = al * bu + k;
    k = t >> 32;
    return [au * bu + w1 + k, t << 32 + w3];
}

/// Fast modular multiplication by barrett reduction
/// Reference: https://en.wikipedia.org/wiki/Barrett_reduction
/// NOTE: reconsider after Ice Lake
struct Barrett
{
    ///
    uint _m;
    ///
    ulong im;
    /// Param: `1 <= m < 2^31`
    this(uint m) @safe @nogc pure nothrow
    {
        _m = m;
        im = (cast(ulong)(-1)) / m + 1;
    }

    /// Return: `m`
    uint umod() @safe @nogc pure nothrow
    {
        return _m;
    }

    /// Param: `0 <= a < m`, `0 <= b < m`
    /// Return: `a * b % m`
    uint mul(uint a, uint b) @safe @nogc pure nothrow
    {
        ulong z = a;
        z *= b;
        immutable ulong x = umul128(z, im)[0];
        uint v = cast(uint)(z - x * _m);
        if (_m <= v)
            v += _m;
        return v;
    }
}

/// Param: `0 <= n`, `1 <= m`
/// Return: `(x ^^ n) % m`
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

/// Reference:
/// M. Forisek and J. Jancina,
/// Fast Primality Testing for Integers That Fit into a Machine Word
/// Param: `0 <= n`
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

/// ditto
enum bool isPrime(int n) = ctIsPrime(n);

/// Param: `1 <= b`
/// Return: `pair(g, x)` s.t. `g = gcd(a, b)`, `x*a = g (mod b)`, `0 <= x < b/g`
Tuple!(long, long) invGcd(long a, long b) @safe pure nothrow @nogc
{
    a = safeMod(a, b);
    if (a == 0)
        return Tuple!(long, long)(b, 0);
    long s = b, t = a, m0 = 0, m1 = 1;
    while (t)
    {
        immutable long u = s / t;
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

/// Compile time primitive root
/// Param: m must be prime
/// Return: primitive root (and minimum in now)
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

/// ditto
enum primitiveRoot(int m) = ctPrimitiveRoot(m);

import std.typecons : Tuple;

long powMod(long x, long n, long m) @safe pure nothrow @nogc
{
    assert(0 <= n && 1 <= m);
    if (m == 1)
        return 0;
    Barrett bt = Barrett(cast(uint) m);
    uint r = 1, y = cast(uint) safeMod(x, m);
    while (n)
    {
        if (n & 1)
            r = bt.mul(r, y);
        y = bt.mul(y, y);
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

int celiPow2(int n) @safe pure nothrow @nogc
{
    int x = 0;
    while ((1u << x) < cast(uint)(n))
        x++;
    return x;
}

struct LazySegTree(S, alias op, alias e, F, alias mapping, alias composition, alias id)
{
    import std.functional : unaryFun, binaryFun;
    import std.traits : isCallable, Parameters;

    static if (is(typeof(e) : string))
    {
        auto unit()
        {
            return mixin(e);
        }
    }
    else
    {
        alias unit = e;
    }
    static if (is(typeof(id) : string))
    {
        auto identity()
        {
            return mixin(id);
        }
    }
    else
    {
        alias identity = id;
    }
public:
    this(int n)
    {
        auto v = new S[](n);
        v[] = unit();
        this(v);
    }

    this(const S[] v)
    {
        _n = cast(int) v.length;
        log = celiPow2(_n);
        size = 1 << log;
        assert(1 <= size);
        d = new S[](2 * size);
        d[] = unit();
        lz = new F[](size);
        lz[] = identity();
        foreach (i; 0 .. _n)
            d[size + i] = v[i];
        foreach_reverse (i; 1 .. size)
            update(i);
    }

    void set(int p, S x)
    {
        assert(0 <= p && p < _n);
        p += size;
        foreach_reverse (i; 1 .. log + 1)
            push(p >> i);
        d[p] = x;
        foreach (i; 1 .. log + 1)
            update(p >> i);
    }

    S get(int p)
    {
        assert(0 <= p && p < _n);
        p += size;
        foreach_reverse (i; 1 .. log + 1)
            push(p >> i);
        return d[p];
    }

    S prod(int l, int r)
    {
        assert(0 <= l && l <= r && r <= _n);
        if (l == r)
            return unit();
        l += size;
        r += size;
        foreach_reverse (i; 1 .. log + 1)
        {
            if (((l >> i) << i) != l)
                push(l >> i);
            if (((r >> i) << i) != r)
                push(r >> i);
        }

        S sml = unit(), smr = unit();
        while (l < r)
        {
            if (l & 1)
                sml = binaryFun!(op)(sml, d[l++]);
            if (r & 1)
                smr = binaryFun!(op)(d[--r], smr);
            l >>= 1;
            r >>= 1;
        }

        return binaryFun!(op)(sml, smr);
    }

    S allProd()
    {
        return d[1];
    }

    void apply(int p, F f)
    {
        assert(0 <= p && p < _n);
        p += size;
        foreach_reverse (i; 1 .. log + 1)
            push(p >> i);
        d[p] = binaryFun!(mapping)(f, d[p]);
        foreach (i; 1 .. log + 1)
            update(p >> i);
    }

    void apply(int l, int r, F f)
    {
        assert(0 <= l && l <= r && r <= _n);
        if (l == r)
            return;
        l += size;
        r += size;
        foreach_reverse (i; 1 .. log + 1)
        {
            if (((l >> i) << i) != l)
                push(l >> i);
            if (((r >> i) << i) != r)
                push((r - 1) >> i);
        }
        {
            int l2 = l, r2 = r;
            while (l < r)
            {
                if (l & 1)
                    all_apply(l++, f);
                if (r & 1)
                    all_apply(--r, f);
                l >>= 1;
                r >>= 1;
            }
            l = l2;
            r = r2;
        }
        foreach (i; 1 .. log + 1)
        {
            if (((l >> i) << i) != l)
                update(l >> i);
            if (((r >> i) << i) != r)
                update((r - 1) >> i);
        }
    }

    int maxRight(alias g)(int l)
    {
        return maxRight(l, unaryFun!(g));
    }

    int maxRight(G)(int l, G g) if (isCallable!G && Parameters!(G).length == 1)
    {
        assert(0 <= l && l <= _n);
        assert(g(unit()));
        if (l == _n)
            return _n;
        l += size;
        foreach_reverse (i; 1 .. log + 1)
            push(l >> i);
        S sm = unit();
        do
        {
            while (l % 2 == 0)
                l >>= 1;
            if (!g(binaryFun!(op)(sm, d[l])))
            {
                while (l < size)
                {
                    push(l);
                    l = 2 * l;
                    if (g(binaryFun!(op)(sm, d[l])))
                    {
                        sm = binaryFun!(op)(sm, d[l]);
                        l++;
                    }
                }
                return l - size;
            }
            sm = binaryFun!(op)(sm, d[l]);
            l++;
        }
        while ((l & -l) != l);
        return _n;
    }

    int minLeft(alias g)(int r)
    {
        return minLeft(r, unaryFun!(g));
    }

    int minLeft(G)(int r, G g) if (isCallable!G && Parameters!(G).length == 1)
    {
        assert(0 <= r && r <= _n);
        assert(g(unit()));
        if (r == 0)
            return 0;
        r += size;
        foreach_reverse (i; 1 .. log + 1)
            push((r - 1) >> i);
        S sm = unit();
        do
        {
            r--;
            while (r > 1 && (r % 2))
                r >>= 1;
            if (!g(binaryFun!(op)(d[r], sm)))
            {
                while (r < size)
                {
                    push(r);
                    r = (2 * r + 1);
                    if (g(binaryFun!(op)(d[r], sm)))
                    {
                        sm = binaryFun!(op)(d[r], sm);
                        r--;
                    }
                }
                return r + 1 - size;
            }
            sm = binaryFun!(op)(d[r], sm);
        }
        while ((r & -r) != r);
        return 0;
    }

private:
    int _n = 0, size = 1, log = 0;
    S[] d = [unit(), unit()];
    F[] lz = [identity()];

    void update(int k)
    {
        d[k] = binaryFun!(op)(d[2 * k], d[2 * k + 1]);
    }

    void all_apply(int k, F f)
    {
        d[k] = binaryFun!(mapping)(f, d[k]);
        if (k < size)
            lz[k] = binaryFun!(composition)(f, lz[k]);
    }

    void push(int k)
    {
        all_apply(2 * k, lz[k]);
        all_apply(2 * k + 1, lz[k]);
        lz[k] = identity();
    }
}

enum P = 998_244_353L;

void main()
{
    int N, Q; get(N, Q);
    auto KK = new long[](N + 1);
    long k;
    foreach (i; 0..N) {
        k = (k * 10 + 1) % P;
        KK[i + 1] = k;
    }
    alias E = Tuple!(int, "l", int, "r", long, "n");
    auto segt = LazySegTree!(
        E,
        (E a, E b) => E(min(a.l, b.l), max(a.r, b.r), (a.n + b.n) % P),
        () => E(0, 0, 0),
        long,
        (long f, E x) => f == 0 ? x : E(x.l, x.r, (KK[x.r] + P - KK[x.l]) % P * f % P),
        (long f, long g) => f ? f : g,
        () => 0
    )(0.iota(N).map!(i => E(i, i + 1, (KK[i + 1] + P - KK[i]) % P)).array().reverse());

    while (Q--) {
        int L, R; long D; get(L, R, D);
        segt.apply(L - 1, R, D);
        writeln(segt.allProd().n);
    }
}
