import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

/// [..)
struct SegTree(alias _fun, alias def, T)
if (is(typeof(def) : T))
{
    import std.functional : binaryFun;
    alias fun = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = 1;
        while (this.n < n) this.n *= 2;
        this.tree.length = this.n * 2 - 1;
        foreach (ref e; this.tree) e = def;
        foreach (i, e; ts) this.put(i, e);
    }

    ///
    void put(size_t i, T e) {
        i += this.n - 1;
        this.tree[i] = e;
        while (i > 0) {
            i = (i-1) / 2;
            this.tree[i] = fun(this.tree[i*2+1], this.tree[i*2+2]);
        }
    }

    ///
    T query(size_t a, size_t b) {
        T impl(size_t i, size_t l, size_t r) {
            if (r <= a || b <= l) return def;
            if (a <= l && r <= b) return this.tree[i];
            return fun(
                impl(i*2+1, l, (l+r)/2),
                impl(i*2+2, (l+r)/2, r)
            );
        }
        return impl(0, 0, this.n);
    }

private:
    size_t n;
    T[] tree;
}

///
SegTree!(f, def, T) seg_tree(alias f, alias def, T)(size_t n, T[] arr = [])
{
    return SegTree!(f, def, T)(n, arr);
}

///
SegTree!(f, def, T) seg_tree(alias f, alias def, T)(T[] arr)
{
    return SegTree!(f, def, T)(arr.length, arr);
}

alias A = Tuple!(int, "i", long, "a");

void main()
{
    auto nkd = readln.split.to!(int[]);
    auto N = nkd[0];
    auto K = nkd[1];
    auto D = nkd[2];
    A[] as;
    foreach (i, a; readln.split.to!(long[])) as ~= A(i.to!int, a);

    if (N <= (K-1)*D) {
        writeln(-1);
        return;
    }

    auto segt = seg_tree!("a.a == b.a ? (a.i < b.i ? a : b) : (a.a < b.a ? a : b)", A(int.max, long.max), A)(as);
    auto a = segt.query(0, N-(K-1)*D);
    int i = a.i;
    long[] rs = [a.a];
    foreach (k; 1..K) {
        a = segt.query(i+D, N-(K-k-1)*D);
        i = a.i;
        rs ~= a.a;
    }
    writeln(rs.to!(string[]).join(" "));
}

/*

3 2
1 2 3 4 5 6 7 8

4 2 2
1 2 3 4

4 3 2
1 2 3 4

5 3 2
1 2 3 4 5

3 3 2
1 2 3


*/