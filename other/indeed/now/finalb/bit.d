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

import std.stdio;

void main()
{
    auto tree = bitree!("a + b", 0, int)(9);

    tree.put(1, 1);
    tree.put(2, 1);
    writeln(tree.query(1));
    writeln(tree.query(2));
    tree.put(4, 1);
    writeln(tree.query(3));
    writeln(tree.query(4));
}