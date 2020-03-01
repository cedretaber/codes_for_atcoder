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
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);
    SegTree!("a + b", 0, int)[] ss;
    ss.length = 26;
    foreach (ref s; ss) s = SegTree!("a + b", 0, int)(N+1, []);
    foreach (i, c; S) {
        ss[c-'a'].put(i, 1);
    }

    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto q = readln.split;
        if (q[0] == "1") {
            auto i = q[1].to!int-1;
            auto c = q[2][0];
            ss[S[i]-'a'].put(i, 0);
            S[i] = c;
            ss[c-'a'].put(i, 1);
        } else {
            auto l = q[1].to!int-1;
            auto r = q[2].to!int;
            int ret;
            foreach (i, ref s; ss) {
                ret += min(s.query(l, r), 1);
            }
            writeln(ret);
        }
    }
}