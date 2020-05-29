import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

struct LazySegTree(alias opt, alias opu, alias _add, alias mul, alias E, alias F, T, U)
if (is(typeof(E) : T) && is(typeof(F) : U))
{
    import std.functional : binaryFun;
    alias OPT = binaryFun!opt;
    alias OPU = binaryFun!opu;
    alias ADD = binaryFun!_add;
    alias MUL = binaryFun!mul;

    ///
    this(size_t n, T[] ts) {
        this.n = 1;
        while (this.n < n) this.n *= 2;
        this.tree.length = this.n * 2 - 1;
        foreach (ref e; this.tree) e = E;
        foreach (i, e; ts) this.replace(i, e);
        this.ltree.length = this.n * 2 - 1;
        foreach (ref f; this.ltree) f = F;
    }

    ///
    void replace(size_t i, T e) {
        i += this.n - 1;
        this.tree[i] = e;
        while (i > 0) {
            i = (i-1) / 2;
            this.tree[i] = OPT(this.tree[i*2+1], this.tree[i*2+2]);
        }
    }

    ///
    void update(size_t i, T e) {
        replace(i, OPT(e, tree[i + this.n - 1]));
    }

    void update(size_t a, size_t b, U e) {
        void impl(size_t i, size_t l, size_t r) {
            eval(i, l, r);
            if (r <= a || b <= l) return;
            if (a <= l && r <= b) {
                ltree[i] = OPU(ltree[i], e);
                eval(i, l, r);
                return;
            }
            impl(i*2+1, l, (l+r)/2);
            impl(i*2+2, (l+r)/2, r);
            tree[i] = OPT(tree[i*2+1], tree[i*2+2]);
        }
        impl(0, 0, this.n);
    }

    ///
    T query(size_t a, size_t b) {
        T impl(size_t i, size_t l, size_t r) {
            eval(i, l, r);
            if (r <= a || b <= l) return E;
            if (a <= l && r <= b) return this.tree[i];
            return OPT(
                impl(i*2+1, l, (l+r)/2),
                impl(i*2+2, (l+r)/2, r)
            );
        }
        return impl(0, 0, this.n);
    }

private:
    size_t n;
    T[] tree;
    U[] ltree;

    void eval(size_t i, size_t l, size_t r) {
        if (ltree[i] == F) return;

        import std.conv;
        tree[i] = ADD(tree[i], MUL(ltree[i], (r-l).to!U));
        if (i < this.n - 1) {
            ltree[2*i+1] = OPU(ltree[2*i+1], ltree[i]);
            ltree[2*i+2] = OPU(ltree[2*i+2], ltree[i]);
        }
        ltree[i] = F;
    }
}

///
auto lazy_seg_tree(alias opt, alias opu, alias add, alias mul, alias E, alias F, T, U)(size_t n, T[] arr = [])
{
    return LazySegTree!(opt, opu, add, mul, E, F, T, T)(n, arr);
}

///
auto lazy_seg_tree(alias opt, alias opu, alias add, alias mul, alias E, alias F, T, U)(T[] arr)
{
    return LazySegTree!(opt, opu, add, mul, E, F, T, T)(arr.length, arr);
}

alias P = Tuple!(int, "i", long, "w");

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    auto T = new P[][N];
    foreach (i; 1..N) {
        auto pw = readln.split.to!(int[]);
        auto p = pw[0]-1;
        long w = pw[1];
        T[p] ~= P(i, w);
    }

    auto gi = new int[N];
    auto bi = new int[N];
    auto ws = new long[N];
    int idx;
    void walk(int i, long w) {
        gi[i] = idx++;
        ws[idx-1] = T[i].empty ? w : long.max/3;
        foreach (e; T[i]) walk(e.i, w + e.w);
        bi[i] = idx;
    }
    walk(0, 0);

    auto segt = lazy_seg_tree!("a < b ? a : b", (_, a) => a, (_, a) => a, (a, _) => a, long.max/3, 0, long, long)(ws);
    foreach (_; 0..Q) {
        auto x = readln.chomp.to!int-1;
        segt.update(gi[x], bi[x], long.max/3);
        auto m = segt.query(0, N);
        writeln(m >= long.max/3 ? -1 : m);
    }
}