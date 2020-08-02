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

auto sum_seg_tree(T)(size_t n, T[] arr = [])
{
    return seg_tree!("a + b", 0, T)(n, arr);
}

auto sum_seg_tree(T)(T[] arr)
{
    return sum_seg_tree!T(arr.length, arr);
}

alias Q = Tuple!(int, "i", int, "l", int, "r");

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto qc = nq[1];
    auto cs = readln.split.to!(int[]);

    Q[] qs;
    foreach (i; 0..qc) {
        auto lr = readln.split.to!(int[]);
        qs ~= Q(i, lr[0]-1, lr[1]);
    }
    sort!"a.r < b.r"(qs);
    auto ls = new int[](N+1);
    ls[] = -1;
    auto segt = sum_seg_tree!int(N);
    auto rs = new int[](qc);
    int last_r = 0;
    foreach (q; qs) {
        while (last_r < q.r) {
            auto c = cs[last_r];
            if (ls[c] != -1) {
                segt.replace(ls[c], 0);
            }
            ls[c] = last_r;
            segt.replace(last_r, 1);
            ++last_r;
        }
        rs[q.i] = segt.query(q.l, q.r);
    }
    foreach (ref r; rs) writeln(r);
}