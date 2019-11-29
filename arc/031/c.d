import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

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

void main()
{
    auto N = readln.chomp.to!int;
    auto bit = bitree!("a + b", 0L, long)(N);
    long r;
    foreach (ii, b; readln.split.to!(long[])) {
        auto i = ii.to!long;
        r += i - bit.query(i+1);
        bit.put(i+1, 1);
    }
    writeln(r);
}