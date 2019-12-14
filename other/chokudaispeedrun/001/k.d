import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.range;

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

enum P = 10L^^9+7;

void main()
{
    auto N = readln.chomp.to!long;
    auto fs = new long[](N);
    fs[1] = 1;
    foreach (i, f; fs) if (i > 1) fs[i] = (fs[i-1] * i.to!long) % P;
    auto tree = bitree!("a + b", 0L, long)(N);
    foreach (i; 1..N+1) tree.put(i, 1);
    long r = 1;
    foreach (i, a; readln.split.to!(long[])) {
        r = (r + (tree.query(a-1) * fs[N-i-1]) % P) % P;
        tree.put(a, -1);
    }
    writeln(r);
}