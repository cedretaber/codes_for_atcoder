import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

/// ..), 0-origin
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

    /// This method does not replace the element but applies old one and new one to the `OP`.
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
    return bitree!("a + b", 0L, T)(n, ts);
}

auto sum_bitree(T)(T[] ts)
{
    return sum_bitree!T(ts.length, ts);
}

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    long K = nk[1];
    long[] AS;
    foreach (_; 0..N) AS ~= readln.chomp.to!long;
    foreach (i; 1..N) AS[i] += AS[i-1];
    long[] BS = [0];
    foreach (i; 0..N) {
        AS[i] -= (i+1).to!long * K;
        BS ~= AS[i];
    }
    sort(BS);
    BS = BS.uniq.array;

    size_t[long] CS;
    foreach (i, b; BS) CS[b] = i;

    auto bit = sum_bitree!long(BS.length);
    bit.update(CS[0], 1);
    long r;
    foreach (a; AS) {
        auto c = CS[a];
        r += bit.query(c+1);
        bit.update(c, 1);
    }
    writeln(r);
}