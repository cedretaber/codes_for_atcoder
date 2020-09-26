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

int celiPow2(int n) @safe pure nothrow @nogc
{
    int x = 0;
    while ((1u << x) < cast(uint)(n))
        x++;
    return x;
}

struct Segtree(S, alias op, alias e)
{
    import std.functional : binaryFun, unaryFun;
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

    this(int n)
    {
        auto buf = new S[](n);
        buf[] = unit();
        this(buf);
    }

    this(S[] v)
    {
        _n = cast(int) v.length;
        log = celiPow2(_n);
        size = 1 << log;
        d = new S[](2 * size);
        d[] = unit();
        foreach (i; 0 .. _n)
            d[size + i] = v[i];
        foreach_reverse (i; 1 .. size)
            update(i);
    }

    void set(int p, S x)
    {
        assert(0 <= p && p < _n);
        p += size;
        d[p] = x;
        foreach (i; 1 .. log + 1)
            update(p >> i);
    }

    S get(int p)
    {
        assert(0 <= p && p < _n);
        return d[p + size];
    }

    S prod(int l, int r)
    {
        assert(0 <= l && l <= r && r <= _n);
        S sml = unit(), smr = unit();
        l += size;
        r += size;
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

    int maxRight(alias f)(int l)
    {
        return maxRight(l, &unaryFun!(f));
    }

    int maxRight(F)(int l, F f) if (isCallable!F && Parameters!(F).length == 1)
    {
        assert(0 <= l && l <= _n);
        assert(f(unit()));
        if (l == _n)
            return _n;
        l += size;
        S sm = unit();
        do
        {
            while (l % 2 == 0)
                l >>= 1;
            if (!f(binaryFun!(op)(sm, d[l])))
            {
                while (l < size)
                {
                    l = 2 * l;
                    if (f(binaryFun!(op)(sm, d[l])))
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

    int minLeft(alias f)(int r)
    {
        return minLeft(r, &unaryFun!(f));
    }

    int minLeft(F)(int r, F f) if (isCallable!F && Parameters!(F).length == 1)
    {
        assert(0 <= r && r <= _n);
        assert(f(unit()));
        if (r == 0)
            return 0;
        r += size;
        S sm = unit();
        do
        {
            r--;
            while (r > 1 && (r % 2))
                r >>= 1;
            if (!f(binaryFun!(op)(d[r], sm)))
            {
                while (r < size)
                {
                    r = 2 * r + 1;
                    if (f(binaryFun!(op)(d[r], sm)))
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
    void update(int k)
    {
        d[k] = binaryFun!(op)(d[2 * k], d[2 * k + 1]);
    }
}

void main()
{
    int N, K; get(N, K);
    auto segt = Segtree!(int, "a >= b ? a : b", () => 0)(300_001);
    while (N--) {
        int A; get(A);
        auto l = segt.prod(max(0, A-K), min(300_000, A+K)+1);
        segt.set(A, l + 1);
    }
    writeln(segt.allProd());
}