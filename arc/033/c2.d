import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

struct BITree(alias _fun, alias E, T)
if (is(typeof(E) : T))
{
    import std.functional : binaryFun;
    alias OP = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = n;
        this.tree.length = n+1;
        foreach (ref e; this.tree) e = E;
        foreach (i, t; ts) this.update(i, t);
    }

    void update(size_t i, T e) {
        i += 1;
        while (i <= this.n) {
            this.tree[i] = OP(this.tree[i], e);
            i += i & -i;
        }
    }

    ///
    T query(size_t i) {
        auto r = E;
        while (i > 0) {
            r = OP(r, this.tree[i]);
            i -= i & -i;
        }
        return r;
    }

private:
    size_t n;
    T[] tree;
}

auto bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
auto bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

auto sum_bitree(T)(size_t n, T[] ts = [])
{
    return bitree!("a + b", cast(T)0, T)(n, ts);
}

auto sum_bitree(T)(T[] ts)
{
    return sum_bitree!T(ts.length, ts);
}

void main()
{
    auto bit = sum_bitree!int(2*10^^5+1);
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto tx = readln.split.to!(int[]);
        auto T = tx[0];
        auto X = tx[1];
        if (T == 1) {
            bit.update(X, 1);
        } else {
            int l, r = 2*10^^5+1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (bit.query(m) < X) {
                    l = m;
                } else {
                    r = m;
                }
            }
            writeln(l);
            bit.update(l, -1);
        }
    }
}