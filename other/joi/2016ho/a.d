import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

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

void main()
{
    auto nmk = readln.split.to!(long[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];

    long[] AS, DP = [0L];
    foreach (i; 0..N) {
        AS ~= readln.chomp.to!long;
        DP ~= long.max;
    }
    foreach (i; 1..N+1) {
        auto min_a = long.max, max_a = 0L;
        foreach_reverse (j; max(0, i-M)..i) {
            min_a = min(min_a, AS[j]);
            max_a = max(max_a, AS[j]);
            auto n = K + (i-j) * (max_a - min_a) + DP[j];
            if (DP[i] > n) DP[i] = n;
        }
    }
    writeln(DP[N]);
}