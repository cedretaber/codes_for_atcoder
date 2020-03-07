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

enum P = 998244353L;

alias R = Tuple!(long, "x", long, "d");

void main()
{
    auto N = readln.chomp.to!long;
    R[] rs;
    foreach (_; 0..N) {
        auto xd = readln.split.to!(long[]);
        rs ~= R(xd[0], xd[1]);
    }
    sort!"a.x < b.x"(rs);

    auto RS = new long[](N);
    foreach_reverse (i; 0..N) {
        if (i == N-1) {
            RS[i] = i;
            continue;
        }
        if (rs[N-1].x < rs[i].x + rs[i].d) {
            RS[i] = N-1;
            continue;
        }
        auto l = i, r = N-1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (rs[m].x >= rs[i].x + rs[i].d) {
                r = m;
            } else {
                l = m;
            }
        }
        RS[i] = l;
    }

    auto DS = new long[](N);
    foreach (i; 0..N) {
        DS[i] = RS[i];
    }
    auto segt = seg_tree!("a > b ? a : b", 0, long)(DS);
    foreach_reverse (i; 0..N) {
        RS[i] = segt.query(i, RS[i]+1);
        segt.put(i, RS[i]);
    }

    auto DP = new long[](N);
    DP[] = -1;
    long solve(long i) {
        if (i == N) return 1;
        if (DP[i] == -1) {
            DP[i] = (solve(i+1) + solve(RS[i]+1)) % P;
        }
        return DP[i];
    }
    writeln(solve(0));
}