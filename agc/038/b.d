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

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto ps = readln.split.to!(int[]);

    int last = -1, cnt;
    auto bs = new bool[](N);
    bool has_nc;
    foreach (i, p; ps) {
        if (p > last) {
            ++cnt;
            if (cnt >= K) {
                bs[i-K+1] = true;
                has_nc = true;
            }
        } else {
            cnt = 1;
        }
        last = p;
    }

    auto ps_min = seg_tree!("a < b ? a : b", int.max)(ps.dup);
    auto ps_max = seg_tree!("a > b ? a : b", -1)(ps.dup);

    int r = bs[0] ? 0 : 1;
    foreach (i; 0..N-K) {
        if (
            (ps_min.query(i, i+K) != ps[i] || ps_max.query(i+1, i+K+1) != ps[i+K]) &&
            bs[i+1] == false
        ) ++r;
    }
    writeln(r + (has_nc ? 1 : 0));
}