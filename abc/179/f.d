import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

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

auto max_seg_tree(T)(size_t n, T[] arr = [])
{
    return seg_tree!("a > b ? a : b", 0, T)(n, arr);
}

auto max_seg_tree(T)(T[] arr)
{
    return max_seg_tree!T(arr.length, arr);
}

alias P = Tuple!(int, "i", int, "d");

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    alias SEGT = typeof(max_seg_tree!int(N));
    long r = (N.to!long-2)^^2;
    void put(int p, ref int min_line, int min_line_opposite, ref int[] lines, SEGT segt) {
        segt.update(p, p+1);
        auto above = segt.query(0, p);
        if (above) {
            lines[p] = lines[above-1];
        } else {
            min_line = p;
            lines[p] = min_line_opposite - 1;
        }
        r -= lines[p];
    }

    auto lms = new int[](N);
    int min_w = N-1;
    auto bms = new int[](N);
    int min_v = N-1;
    auto wsegt = max_seg_tree!int(N);
    auto vsegt = max_seg_tree!int(N);
    foreach (_; 0..Q) {
        auto q = readln.split.to!(int[]);
        auto x = q[1]-1;
        if (q[0] == 1) {
            put(x, min_v, min_w, lms, wsegt);
        } else {
            put(x, min_w, min_v, bms, vsegt);
        }
    }
    writeln(r);
}