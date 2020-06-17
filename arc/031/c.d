import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

struct SegTree(alias fun, alias E, T)
if (is(typeof(E) : T))
{
    import std.functional : binaryFun;
    alias OP = binaryFun!fun;

    ///
    this(size_t n, T[] ts) {
        this.n = 1;
        while (this.n < n) this.n *= 2;
        this.tree.length = this.n * 2 - 1;
        foreach (ref e; this.tree) e = E;
        foreach (i, e; ts) this.update(i, e);
    }

    ///
    void replace(size_t i, T e) {
        i += this.n - 1;
        this.tree[i] = e;
        while (i > 0) {
            i = (i-1) / 2;
            this.tree[i] = OP(this.tree[i*2+1], this.tree[i*2+2]);
        }
    }

    ///
    void update(size_t i, T e) {
        replace(i, OP(e, tree[i + this.n - 1]));
    }

    ///
    T query(size_t a, size_t b) {
        T impl(size_t i, size_t l, size_t r) {
            if (r <= a || b <= l) return E;
            if (a <= l && r <= b) return this.tree[i];
            return OP(
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
auto seg_tree(alias f, alias E, T)(size_t n, T[] arr = [])
{
    return SegTree!(f, E, T)(n, arr);
}

///
auto seg_tree(alias f, alias E, T)(T[] arr)
{
    return SegTree!(f, E, T)(arr.length, arr);
}

auto sum_seg_tree(T)(size_t n, T[] arr = [])
{
    return seg_tree!("a + b", 0, T)(n, arr);
}

auto sum_seg_tree(T)(T[] arr)
{
    return sum_seg_tree!T(arr.length, arr);
}

void main()
{
    auto N = readln.chomp.to!int;
    auto ii = new int[](N+1);
    ii[] = -1;
    auto segt = sum_seg_tree!int(N);
    foreach (i, b; readln.split.to!(int[])) {
        ii[b] = i.to!int;
        segt.replace(i, 1);
    }
    long r;
    foreach (b; 0..N+1) if (ii[b] != -1) {
        auto i = ii[b];
        segt.replace(i, 0);
        if (i == 0 || i == N-1) continue;
        r += min(segt.query(0, i), segt.query(i+1, N));
    }
    writeln(r);
}