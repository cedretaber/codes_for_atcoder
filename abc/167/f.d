import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

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

alias B = Tuple!(int, "i", int, "in_cnt", int, "out_cnt");

void main()
{
    auto N = readln.chomp.to!int;
    B[] bs;
    foreach (_; 0..N) {
        bool fst;
        int cnt, min_cnt;
        foreach (c; readln.chomp) {
            if (c == ')') {
                --cnt;
            } else {
                ++cnt;
            }
            min_cnt = min(min_cnt, cnt);
        }
        bs ~= B(0, min_cnt, cnt);
    }
    sort!"a.in_cnt > b.in_cnt"(bs);
    foreach (i, ref b; bs) b.i = i.to!int;
    auto E = B(0, 0, int.min/3);
    auto segt = seg_tree!("a.out_cnt == b.out_cnt ? a.in_cnt < b.in_cnt ? a : b : a.out_cnt > b.out_cnt ? a : b", E, B)(bs);

    int cnt;
    foreach (_; 0..N) {
        int i;
        if (bs[$-1].in_cnt + cnt >= 0) {
            i = N;
        } else if (bs[0].in_cnt + cnt < 0) {
            writeln("No");
            return;
        } else {
            int l, r = N-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (bs[m].in_cnt + cnt >= 0) {
                    l = m;
                } else {
                    r = m;
                }
            }
            i = r;
        }
        auto max_b = segt.query(0, i);
        cnt += max_b.out_cnt;
        segt.replace(max_b.i, E);
        if (cnt < 0) {
            writeln("No");
            return;
        }
    }
    writeln(cnt == 0 ? "Yes" : "No");
}