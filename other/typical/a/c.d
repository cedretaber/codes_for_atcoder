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

void main()
{
    int W, N; get(W, N);
    auto segt = LazySegTree!(
        int,
        (int a, int b) => max(a, b),
        () => 0,
        int,
        (int f, int x) => max(f, x),
        (int f, int g) => max(f, g),
        () => 0
    )(W);

    while (N--) {
        int L, R; get(L, R); --L;
        auto x = segt.prod(L, R) + 1;
        writeln(x);
        segt.apply(L, R, x);
    }
}
