import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
            args[0] = readln.split.to!Arg;
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

ulong safeMod(long x, long m) @safe pure nothrow @nogc
{
    x %= m;
    if (x < 0)
        x += m;
    return x;
}

ulong[2] umul128(ulong a, ulong b) @safe @nogc pure nothrow
{
    ulong au = a >> 32;
    ulong bu = b >> 32;
    ulong al = a & ((1UL << 32) - 1);
    ulong bl = b & ((1UL << 32) - 1);
    ulong t = al * bl;
    ulong w3 = t & ((1UL << 32) - 1);
    ulong k = t >> 32;
    t = au * bl + k;
    k = t & ((1UL << 32) - 1);
    ulong w1 = t >> 32;
    t = al * bu + k;
    k = t >> 32;
    return [au * bu + w1 + k, t << 32 + w3];
}

struct Barrett
{
    uint _m;
    ulong im;
    this(uint m) @safe @nogc pure nothrow
    {
        _m = m;
        im = (cast(ulong)(-1)) / m + 1;
    }

    uint umod() @safe @nogc pure nothrow
    {
        return _m;
    }

    uint mul(uint a, uint b) @safe @nogc pure nothrow
    {
        ulong z = a;
        z *= b;
        ulong x = umul128(z, im)[0];
        uint v = cast(uint)(z - x * _m);
        if (_m <= v)
            v += _m;
        return v;
    }
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

struct StaticModInt(int m) if (1 <= m)
{
    import std.traits : isSigned, isUnsigned, isSomeChar;

    alias mint = StaticModInt;
public:
    static int mod()
    {
        return m;
    }

    static mint raw(int v)
    {
        mint x;
        x._v = v;
        return x;
    }

    this(T)(T v) if (isSigned!T)
    {
        long x = cast(long)(v % cast(long)(umod()));
        if (x < 0)
            x += umod();
        _v = cast(uint)(x);
    }

    this(T)(T v) if (isUnsigned!T || isSomeChar!T)
    {
        _v = cast(uint)(v % umod());
    }

    this(bool v)
    {
        _v = cast(uint)(v) % umod();
    }

    auto opAssign(T)(T v)
            if (isSigned!T || isUnsigned!T || isSomeChar!T || is(T == bool))
    {
        return this = mint(v);
    }

    inout uint val() pure
    {
        return _v;
    }

    ref mint opUnary(string op)() pure nothrow @safe if (op == "++")
    {
        _v++;
        if (_v == umod())
            _v = 0;
        return this;
    }

    ref mint opUnary(string op)() pure nothrow @safe if (op == "--")
    {
        if (_v == 0)
            _v = umod();
        _v--;
        return this;
    }

    mint opUnary(string op)() if (op == "+" || op == "-")
    {
        mint x;
        return mixin("x " ~ op ~ " this");
    }

    ref mint opOpAssign(string op, T)(T value) if (!is(T == mint))
    {
        mint y = value;
        return opOpAssign!(op)(y);
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "+" && is(T == mint))
    {
        _v += value._v;
        if (_v >= umod())
            _v -= umod();
        return this;
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "-" && is(T == mint))
    {
        _v -= value._v;
        if (_v >= umod())
            _v += umod();
        return this;
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "*" && is(T == mint))
    {
        ulong z = _v;
        z *= value._v;
        _v = cast(uint)(z % umod());
        return this;
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "/" && is(T == mint))
    {
        return this = this * value.inv();
    }

    mint pow(long n) const pure
    {
        assert(0 <= n);
        mint x = this, r = 1;
        while (n)
        {
            if (n & 1)
                r *= x;
            x *= x;
            n >>= 1;
        }
        return r;
    }

    mint inv() const pure
    {
        static if (prime)
        {
            assert(_v);
            return pow(umod() - 2);
        }
        else
        {
            auto eg = invGcd(_v, mod());
            assert(eg[0] == 1);
            return mint(eg[1]);
        }
    }

    mint opBinary(string op, R)(const R value) const pure 
            if (op == "+" || op == "-" || op == "*" || op == "/")
    {
        static if (is(R == mint))
        {
            mint x;
            x += this;
            return x.opOpAssign!(op)(value);
        }
        else
        {
            mint y = value;
            return opOpAssign!(op)(y);
        }
    }

    mint opBinaryRight(string op, L)(const L value) const if (!is(L == mint))
    {
        mint y = value;
        return y.opBinary!(op)(this);
    }

    bool opEquals(R)(const R value) const
    {
        static if (is(R == mint))
        {
            return _v == value._v;
        }
        else
        {
            mint y = mint(value);
            return this == y;
        }
    }

private:
    uint _v;
    uint umod() pure const
    {
        return m;
    }

    enum bool prime = isPrime!(m);
}

struct DynamicModInt(int id)
{
    import std.traits : isSigned, isUnsigned, isSomeChar;

    alias mint = DynamicModInt;
public:
    static int mod()
    {
        return bt.umod();
    }

    static void setMod(int m)
    {
        assert(1 <= m);
        bt = Barrett(m);
    }

    static mint raw(int v)
    {
        mint x;
        x._v = v;
        return x;
    }

    this(T)(T v) if (isSigned!T)
    {
        long x = cast(long)(v % cast(long)(umod()));
        if (x < 0)
            x += umod();
        _v = cast(uint)(x);
    }

    this(T)(T v) if (isUnsigned!T || isSomeChar!T)
    {
        _v = cast(uint)(v % umod());
    }

    this(bool v)
    {
        _v = cast(uint)(v) % umod();
    }

    auto opAssign(T)(T v)
            if (isSigned!T || isUnsigned!T || isSomeChar!T || is(T == bool))
    {
        return this = mint(v);
    }

    inout uint val()
    {
        return _v;
    }

    ref mint opUnary(string op)() nothrow @safe if (op == "++")
    {
        _v++;
        if (_v == umod())
            _v = 0;
        return this;
    }

    ref mint opUnary(string op)() nothrow @safe if (op == "--")
    {
        if (_v == 0)
            _v = umod();
        _v--;
        return this;
    }

    mint opUnary(string op)() if (op == "+" || op == "-")
    {
        mint x;
        return mixin("x " ~ op ~ " this");
    }

    ref mint opOpAssign(string op, T)(T value) if (!is(T == mint))
    {
        mint y = value;
        return opOpAssign!(op)(y);
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "+" && is(T == mint))
    {
        _v += value._v;
        if (_v >= umod())
            _v -= umod();
        return this;
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "-" && is(T == mint))
    {
        _v -= value._v;
        if (_v >= umod())
            _v += umod();
        return this;
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "*" && is(T == mint))
    {
        _v = bt.mul(_v, value._v);
        return this;
    }

    ref mint opOpAssign(string op, T)(T value) if (op == "/" && is(T == mint))
    {
        return this = this * value.inv();
    }

    mint pow(long n) const
    {
        assert(0 <= n);
        mint x = this, r = 1;
        while (n)
        {
            if (n & 1)
                r *= x;
            x *= x;
            n >>= 1;
        }
        return r;
    }

    mint inv() const
    {
        auto eg = invGcd(_v, mod());
        assert(eg[0] == 1);
        return mint(eg[1]);
    }

    mint opBinary(string op, R)(const R value)
            if (op == "+" || op == "-" || op == "*" || op == "/")
    {
        static if (is(R == mint))
        {
            mint x;
            x += this;
            return x.opOpAssign!(op)(value);
        }
        else
        {
            mint y = value;
            return opOpAssign!(op)(y);
        }
    }

    mint opBinaryRight(string op, L)(const L value) const if (!is(L == mint))
    {
        mint y = value;
        return y.opBinary!(op)(this);
    }

    bool opEquals(R)(const R value) const
    {
        static if (is(R == mint))
        {
            return _v == value._v;
        }
        else
        {
            mint y = mint(value);
            return this == y;
        }
    }

private:
    uint _v;
    static Barrett bt = Barrett(998_244_353);
    uint umod()
    {
        return bt.umod();
    }
}

alias modint998244353 = StaticModInt!(998244353);
alias modint1000000007 = StaticModInt!(1000000007);
alias modint = DynamicModInt!(-1);

int celiPow2(int n) @safe pure nothrow @nogc
{
    int x = 0;
    while ((1u << x) < cast(uint)(n))
        x++;
    return x;
}

import std.traits : isInstanceOf, isIntegral;

void butterfly(mint)(mint[] a) @safe nothrow @nogc
        if (isInstanceOf!(StaticModInt, mint))
{
    import core.bitop : bsf;

    static immutable int g = primitiveRoot!(mint.mod());
    int n = cast(int) a.length;
    int h = celiPow2(n);

    static bool first = true;
    static mint[30] sum_e;
    if (first)
    {
        first = false;
        mint[30] es, ies;
        int cnt2 = bsf(mint.mod() - 1);
        mint e = mint(g).pow((mint.mod() - 1) >> cnt2);
        mint ie = e.inv();
        foreach_reverse (i; 2 .. cnt2 + 1)
        {
            es[i - 2] = e;
            ies[i - 2] = ie;
            e *= e;
            ie *= ie;
        }
        mint now = 1;
        foreach (i; 0 .. cnt2 - 2 + 1)
        {
            sum_e[i] = es[i] * now;
            now *= ies[i];
        }
    }
    foreach (ph; 1 .. h + 1)
    {
        int w = 1 << (ph - 1), p = 1 << (h - ph);
        mint now = 1;
        foreach (s; 0 .. w)
        {
            int offset = s << (h - ph + 1);
            foreach (i; 0 .. p)
            {
                auto l = a[i + offset];
                auto r = a[i + offset + p] * now;
                a[i + offset] = l + r;
                a[i + offset + p] = l - r;
            }
            now *= sum_e[bsf(~(cast(uint) s))];
        }
    }
}

void butterflyInv(mint)(mint[] a) @safe nothrow @nogc
        if (isInstanceOf!(StaticModInt, mint))
{
    import core.bitop : bsf;

    static immutable int g = primitiveRoot!(mint.mod());
    int n = cast(int) a.length;
    int h = celiPow2(n);

    static bool first = true;
    static mint[30] sum_ie;
    if (first)
    {
        first = false;
        mint[30] es, ies;
        int cnt2 = bsf(mint.mod() - 1);
        mint e = mint(g).pow((mint.mod() - 1) >> cnt2);
        mint ie = e.inv();
        foreach_reverse (i; 2 .. cnt2 + 1)
        {
            es[i - 2] = e;
            ies[i - 2] = ie;
            e *= e;
            ie *= ie;
        }
        mint now = 1;
        foreach (i; 0 .. cnt2 - 2 + 1)
        {
            sum_ie[i] = ies[i] * now;
            now *= es[i];
        }
    }

    foreach_reverse (ph; 1 .. h + 1)
    {
        int w = 1 << (ph - 1), p = 1 << (h - ph);
        mint inow = 1;
        foreach (s; 0 .. w)
        {
            int offset = s << (h - ph + 1);
            foreach (i; 0 .. p)
            {
                auto l = a[i + offset];
                auto r = a[i + offset + p];
                a[i + offset] = l + r;
                a[i + offset + p] = mint(cast(ulong)(mint.mod() + l.val() - r.val()) * inow.val());
            }
            inow *= sum_ie[bsf(~(cast(uint) s))];
        }
    }
}

mint[] convolution(mint)(mint[] a, mint[] b) @safe nothrow 
        if (isInstanceOf!(StaticModInt, mint))
{
    import std.algorithm : min, swap;

    int n = cast(int) a.length, m = cast(int) b.length;
    if (!n || !m)
        return [];
    if (min(n, m) <= 60)
    {
        if (n < m)
        {
            swap(n, m);
            swap(a, b);
        }
        auto ans = new mint[](n + m - 1);
        foreach (i; 0 .. n)
            foreach (j; 0 .. m)
                ans[i + j] += a[i] * b[j];
        return ans;
    }
    int z = 1 << celiPow2(n + m - 1);
    a.length = z;
    butterfly(a);
    b.length = z;
    butterfly(b);
    foreach (i; 0 .. z)
        a[i] *= b[i];
    butterflyInv(a);
    a.length = n + m - 1;
    mint iz = mint(z).inv();
    foreach (i; 0 .. n + m - 1)
        a[i] *= iz;
    return a;
}

T[] convolution(uint mod = 998_244_353, T)(T[] a, T[] b) @safe nothrow 
        if (isIntegral!(T))
{
    int n = cast(int)(a.length), m = cast(int)(b.length);
    if (!n || !m)
        return [];
    alias mint = StaticModInt!(mod);
    auto a2 = new mint[](n), b2 = new mint[](m);
    foreach (i; 0 .. n)
        a2[i] = mint(a[i]);
    foreach (i; 0 .. m)
        b2[i] = mint(b[i]);
    auto c2 = convolution(a2, b2);
    auto c = new T[](n + m - 1);
    foreach (i; 0 .. n + m - 1)
        c[i] = c2[i].val();
    return c;
}

long[] convolutionLL(long[] a, long[] b) @safe nothrow
{
    int n = cast(int)(a.length), m = cast(int)(b.length);
    if (!n || !m)
        return [];
    static immutable ulong MOD1 = 90 * (2 ^^ 23) + 1;
    static immutable ulong MOD2 = 10 * (2 ^^ 24) + 1;
    static immutable ulong MOD3 = 14 * (2 ^^ 25) + 1;
    static assert(MOD1 == 754_974_721 && MOD2 == 167_772_161 && MOD3 == 469_762_049);
    static immutable ulong M2M3 = MOD2 * MOD3;
    static immutable ulong M1M3 = MOD1 * MOD3;
    static immutable ulong M1M2 = MOD1 * MOD2;
    static immutable ulong M1M2M3 = MOD1 * MOD2 * MOD3;
    static immutable ulong i1 = invGcd(MOD2 * MOD3, MOD1)[1];
    static immutable ulong i2 = invGcd(MOD1 * MOD3, MOD2)[1];
    static immutable ulong i3 = invGcd(MOD1 * MOD2, MOD3)[1];

    auto c1 = convolution!(MOD1)(a, b);
    auto c2 = convolution!(MOD2)(a, b);
    auto c3 = convolution!(MOD3)(a, b);

    auto c = new long[](n + m - 1);
    foreach (i; 0 .. n + m - 1)
    {
        ulong x;
        x += (c1[i] * i1) % MOD1 * M2M3;
        x += (c2[i] * i2) % MOD2 * M1M3;
        x += (c3[i] * i3) % MOD3 * M1M2;
        long diff = c1[i] - safeMod(cast(long) x, cast(long) MOD1);
        if (diff < 0)
            diff += MOD1;
        static immutable ulong[5] offset = [0, 0, M1M2M3, 2 * M1M2M3, 3 * M1M2M3];
        x -= offset[diff % 5];
        c[i] = x;
    }
    return c;
}

void main()
{
    int N; get(N);
    auto memo = new int[](100_001);
    foreach (_; 0..N*2) {
        int h; get(h);
        ++memo[h];
    }
    long[] hs;
    foreach (h, n; memo) if (n > 0) {
        if (n > N) {
            writeln(0);
            return;
        }
        hs ~= h.to!long;
    }
    writeln(convolution(hs, [1,1]));
}

/*

2 1 1
-> 2

3 2 2 1 1 1
-> 516



*/