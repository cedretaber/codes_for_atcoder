import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct BITree(alias _fun, alias init, T)
if (is(typeof(init) : T))
{
    import std.functional : binaryFun;
    alias fun = binaryFun!_fun;

    ///
    this(size_t n, T[] ts) {
        this.n = n;
        this.tree.length = n+1;
        foreach (ref e; this.tree) e = init;
        foreach (i, t; ts) this.put(i+1, t);
    }

    ///
    void put(size_t i, T e) {
        while (i <= this.n) {
            this.tree[i] = fun(this.tree[i], e);
            i += i & -i;
        }
    }

    ///
    T query(size_t i) {
        auto r = init;
        while (i > 0) {
            r = fun(r, this.tree[i]);
            i -= i & -i;
        }
        return r;
    }

private:
    size_t n;
    T[] tree;
}

///
BITree!(fun, init, T) bitree(alias fun, alias init, T)(size_t n, T[] ts = [])
{
    return BITree!(fun, init, T)(n, ts);
}

///
BITree!(fun, init, T) bitree(alias fun, alias init, T)(T[] ts)
{
    return BITree!(fun, init, T)(ts.length, ts);
}

alias VW = Tuple!(long, "v", long, "w");

enum MAX = 200*1000+1;
long N, W;
VW[200] VWS;
long[][200] DP;

void solve_30()
{
    VW[1<<16] LEFT;
    auto llen = min(16, N+1);
    foreach (b; 0..1<<llen) {
        auto j = b;
        long v, w;
        size_t i;
        while (b) {
            if (b&1) {
                v += VWS[i].v;
                w += VWS[i].w;
            }
            ++i;
            b>>=1;
        }
        LEFT[j] = VW(v, w);
    }
    sort!"a.w < b.w"(LEFT[0..1<<llen]);
    auto bt = bitree!("a.v > b.v ? a : b", VW())(LEFT[0..1<<llen]);
    if (N <= 15) {
        size_t l_i = 0, r_i = 1<<llen;
        while (l_i+1 != r_i) {
            auto m_i = (l_i+r_i)/2;
            if (LEFT[m_i].w <= W) {
                l_i = m_i;
            } else {
                r_i = m_i;
            }
        }
        writeln(bt.query(r_i).v);
    } else {
        auto rlen = (N-15)+1;
        long max_v;
        foreach (b; 0..1<<rlen) {
            long v, w;
            size_t i;
            while (b) {
                if (b&1) {
                    v += VWS[15+i].v;
                    w += VWS[15+i].w;
                }
                ++i;
                b>>=1;
            }
            if (LEFT[0].w + w > W) continue;
            size_t l_i = 0, r_i = 1<<llen;
            while (l_i+1 != r_i) {
                auto m_i = (l_i+r_i)/2;
                if (LEFT[m_i].w <= W-w) {
                    l_i = m_i;
                } else {
                    r_i = m_i;
                }
            }
            max_v = max(max_v, bt.query(r_i).v + v);
        }
        writeln(max_v);
    }
}

void solve_v()
{
    foreach (ref dp; DP) {
        dp.length = MAX;
        foreach (ref e; dp) e = long.max / 3;
    }
    foreach_reverse (i; 0..N) {
        foreach (v; 0..MAX) {
            if (!v) {
                DP[i][v] = 0;
            } else if (i == N-1) {
                if (v == VWS[i].v) DP[i][v] = VWS[i].w;
            } else if (v >= VWS[i].v) {
                DP[i][v] = min(DP[i+1][v], DP[i+1][v-VWS[i].v] + VWS[i].w);
            } else {
                DP[i][v] = DP[i+1][v];
            }
        }
    }
    long r;
    foreach (long v, w; DP[0]) {
        if (w <= W) r = max(r, v);
    }
    writeln(r);
}

void solve_w()
{
    foreach (ref dp; DP) dp.length = MAX;
    foreach_reverse (i; 0..N) {
        foreach (w; 0..MAX) {
            if (VWS[i].w <= w && i < N-1) {
                DP[i][w] = max(DP[i+1][w], DP[i+1][w-VWS[i].w] + VWS[i].v);
            } else if (i < N-1) {
                DP[i][w] = DP[i+1][w];
            } else if (VWS[i].w == w) {
                DP[i][w] = VWS[i].v;
            }
        }
    }
    long r;
    foreach (w, v; DP[0]) {
        if (w > W) break;
        r = max(r, v);
    }
    writeln(r);
}

void main()
{
    auto nw = readln.split.to!(long[]);
    N = nw[0];
    W = nw[1];

    long max_v, max_w;
    foreach (i; 0..N) {
        auto vw = readln.split.to!(long[]);
        VWS[i] = VW(vw[0], vw[1]);
        max_v = max(max_v, vw[0]);
        max_w = max(max_w, vw[1]);
    }

    if (N <= 30) {
        solve_30();
    } else if (max_v <= 1000) {
        solve_v();
    } else {
        solve_w();
    }
}