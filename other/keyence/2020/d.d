import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

/// [..), 1-origin
struct BITree(alias _fun, alias init, T)
if (is(typeof(init) : T))
{
    import std.functional : binaryFun;
    alias fun = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = n;
        this.tree.length = n+1;
        do_init();
        foreach (i, t; ts) this.put(i+1, t);
    }

    void do_init() {
        foreach (ref e; this.tree) e = init;
    }

    /// This method does not replace the element but applies old one and new one to the `fun`.
    void put(size_t i, T e) {
        while (i <= this.n) {
            this.tree[i] = fun(this.tree[i], e);
            i += i & -i;
        }
    }

    ///
    T query(size_t i) {
        auto r = init;
        while (i > 0) {
            r = fun(r, this.tree[i]);
            i -= i & -i;
        }
        return r;
    }

private:
    size_t n;
    T[] tree;
}

/// The `init` value is used for the `query` method as first value,
/// so you can not use this argument to initialise the tree.
/// In other words, this is identity element.
BITree!(fun, init, T) bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
BITree!(fun, init, T) bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

alias Card = Tuple!(int, "a", int, "b");

void main()
{
    auto N = readln.chomp.to!int;
    Card[] cs;
    cs.length = N;
    foreach (i, a; readln.split.to!(int[])) cs[i].a = a;
    foreach (i, b; readln.split.to!(int[])) cs[i].b = b;

    auto ds = new int[](N);
    int res = -1;
    auto bit = bitree!("a + b", 0, int)(N+1);
    void solve(int i, int p, uint s) {
        if (i == N) {
            if (res == -1) res = int.max;
            bit.do_init();
            int rr;
            foreach (j, d; ds) {
                bit.put(d+1, 1);
                rr += (j+1) - bit.query((d+1).to!size_t);
            }
            res = min(res, rr);
        } else {
            foreach (j, c; cs) if (!((1<<j) & s)) {
                auto x = i%2 == j%2 ? c.a : c.b;
                if (x >= p) {
                    ds[i] = j.to!int;
                    solve(i+1, x, s | (1<<j));
                }
            }
        }
    }
    solve(0, 0, 0);
    writeln(res);
}