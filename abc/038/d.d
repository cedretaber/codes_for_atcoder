import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct BITree(alias _fun, alias init, T)
if (is(typeof(init) : T))
{
    import std.functional : binaryFun;
    alias fun = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = n;
        this.tree.length = n+1;
        foreach (ref e; this.tree) e = init;
        foreach (i, t; ts) this.put(i+1, t);
    }

    ///
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

///
BITree!(fun, init, T) bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
BITree!(fun, init, T) bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

alias P = Tuple!(int, "w", int, "h");
P[10^^5] PS;
int[10^^5] DP;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto wh = readln.split.to!(int[]);
        PS[i] = P(wh[0], wh[1]);
    }
    sort!"a.w == b.w ? a.h > b.h : a.w < b.w"(PS[0..N]);

    auto tree = bitree!("a > b ? a : b", 0, int)(10^^5);

    foreach (p; PS[0..N]) {
        auto max_h = tree.query(p.h-1);
        if (!max_h) {
            tree.put(p.h, 1);
        } else {
            tree.put(p.h, max_h + 1);
        }
    }

    writeln(tree.query(10^^5));
}