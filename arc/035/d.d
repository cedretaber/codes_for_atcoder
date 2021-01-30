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

int celiPow2(int n)
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
        this(new S[](n));
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
        return maxRight(l, unaryFun!(f));
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
        return minLeft(r, unaryFun!(f));
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
    int _n, size, log;
    S[] d;
    void update(int k)
    {
        d[k] = binaryFun!(op)(d[2 * k], d[2 * k + 1]);
    }
}


void main()
{
    int N; get(N);
    int[] ps, qs; get_lines(N, ps, qs);

    auto FS = new double[](10^^6 * 2 + 1);
    FS[0] = 0;
    foreach (i; 1..10^^6 * 2 + 1) FS[i] = FS[i-1] + log2(i.to!double);

    double[] ss;
    foreach (i; 0..N-1) {
        auto x = ps[i+1] - ps[i];
        auto y = qs[i+1] - qs[i];
        ss ~= FS[x + y] - FS[x] - FS[y];
    }

    auto segt = Segtree!(double, "a + b", () => 0.0)(ss);

    int Q; get(Q);
    while (Q--) {
        auto q = readln.split.to!(int[]);
        if (q[0] == 1) {
            auto k = q[1] - 1, a = q[2], b = q[3];
            ps[k] = a;
            qs[k] = b;
            if (k > 0) {
                auto x = ps[k] - ps[k-1];
                auto y = qs[k] - qs[k-1];
                segt.set(k-1, FS[x + y] - FS[x] - FS[y]);
            }
            if (k < N-1) {
                auto x = ps[k+1] - ps[k];
                auto y = qs[k+1] - qs[k];
                segt.set(k, FS[x + y] - FS[x] - FS[y]);
            }
        } else {
            auto l1 = q[1] - 1, r1 = q[2] - 1, l2 = q[3] - 1, r2 = q[4] - 1;
            writeln(segt.prod(l1, r1) > segt.prod(l2, r2) ? "FIRST" : "SECOND");
        }
    }
}