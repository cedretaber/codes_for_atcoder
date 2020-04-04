import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

/// [..], 1-origin
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

BITree!(fun, init, T) bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
BITree!(fun, init, T) bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

void main()
{
    auto N = readln.chomp.to!int;
    long[] as, bs;
    foreach (a; readln.split.to!(long[])) {
        as ~= a;
        bs ~= a;
    }
    sort(bs);
    int[long] ator;
    foreach (i, b; bs) {
        if (b in ator) {
            writeln(-1);
            return;
        }
        ator[b] = i.to!int;
    }
    int[] ii;
    ii.length = N;
    foreach (i, a; as) {
        ii[ator[a]] = i.to!int;
    }

    auto bit = bitree!("a + b", 0L, long)(N+1);
    long r;
    foreach_reverse (j, i; ii) {
        r += bit.query(i+1) * bs[j];
        bit.put(i+1, 1);
    }
    writeln(r);
}