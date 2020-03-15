import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct PriorityQueue(alias _fun, T) {
    import std.functional : binaryFun;
    import std.algorithm : swap;
    alias fun = binaryFun!_fun;

    ///
    this(T[] ts) {
        foreach (t; ts) enqueue(t);
    }

    ///
    PriorityQueue!(_fun, T) enqueue(T e) {
        if (this.tree.length == 0) this.tree.length = 1;
        if (this.tree.length == this.n) this.tree.length *= 2;
        this.tree[this.n] = e;
        auto i = this.n;
        this.n += 1;
        while (i) {
            auto j = (i-1)/2;
            if (fun(this.tree[i], this.tree[j])) {
                swap(this.tree[i], this.tree[j]);
                i = j;
            } else break;
        }
        return this;
    }

    alias insertFront = enqueue;
    alias insert = enqueue;

    ///
    T dequeue() {
        auto ret = this.tree[0];
        this.n -= 1;
        this.tree[0] = this.tree[this.n];
        this.tree = this.tree[0..$-1];
        size_t i;
        for (;;) {
            auto l = i*2+1;
            auto r = i*2+2;
            if (l >= this.n) break;
            size_t j;
            if (r >= this.n) {
                j = l;
            } else {
                j = fun(this.tree[r], this.tree[l]) ? r : l;
            }
            if (fun(this.tree[j], this.tree[i])) {
                swap(this.tree[i], this.tree[j]);
                i = j;
            } else break;
        }
        return ret;
    }

    ///
    @property
    T front() {
        return this.tree[0];
    }

    ///
    @property
    bool empty() {
        return this.n == 0;
    }

    ///
    void popFront() {
        this.dequeue();
    }

    alias removeFront = popFront;

    ///
    @property
    size_t length() {
        return this.n;
    }

private:
    size_t n;
    T[] tree;
}

///
PriorityQueue!(fun, T) priority_queue(alias fun, T)(T[] ts = []) {
    return PriorityQueue!(fun, T)(ts);
}

alias P = Tuple!(int, "to", long, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto wxyz = readln.split.to!(int[]);
    auto w = wxyz[0];
    auto x = wxyz[1];
    auto y = wxyz[2];
    auto z = wxyz[3];

    P[][] G, R;
    G.length = N+2;
    R.length = N+2;

    foreach (_; 0..M) {
        auto cst = readln.split.to!(int[]);
        long c = cst[0];
        auto s = cst[1];
        auto t = cst[2];

        G[s] ~= P(t, c);
        R[t] ~= P(s, c);
    }

    long[][] dd;
    dd.length = 5;
    foreach (ref d; dd) {
        d.length = N+2;
        d[] = long.max/3;
    }
    foreach (i, s; [w, x, y, z]) {
        dd[i][s] = 0;
        auto g = i%2 == 0 ? G : R;
        auto pq = priority_queue!("a.c < b.c", P)([P(s, 0)]);
        while (!pq.empty) {
            auto h = pq.dequeue();
            foreach (n; g[h.to]) if (dd[i][n.to] > h.c + n.c) {
                dd[i][n.to] = h.c + n.c;
                pq.enqueue(P(n.to, dd[i][n.to]));
            }
        }
    }
    foreach (i; 1..N+1) {
        G[0] ~= P(i, dd[0][i] + dd[2][i]);
        G[i] ~= P(N+1, dd[1][i] + dd[3][i]);
    }
    dd[4][0] = 0;
    auto pq = priority_queue!("a.c < b.c", P)([P(0, 0)]);
    while (!pq.empty) {
        auto h = pq.dequeue();
        foreach (n; G[h.to]) if (dd[4][n.to] > h.c + n.c) {
            dd[4][n.to] = h.c + n.c;
            pq.enqueue(P(n.to, dd[4][n.to]));
        }
    }

    auto r = min(dd[0][x] + dd[2][z], dd[4][N+1]);
    if (r >= long.max/4) {
        writeln("Impossible");
    } else {
        writeln(r);
    }
}