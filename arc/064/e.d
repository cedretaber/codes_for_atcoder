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

alias P = Tuple!(double, "x", double, "y", double, "r");
P[1002] PS;

alias Q = Tuple!(int, "i", double, "d");

void main()
{
    auto xy = readln.split.to!(double[]);
    auto N = readln.chomp.to!int;
    PS[0] = P(xy[0], xy[1], 0);
    PS[N+1] = P(xy[2], xy[3], 0);
    foreach (i; 1..N+1) {
        auto xyr = readln.split.to!(double[]);
        PS[i] = P(xyr[0], xyr[1], xyr[2]);
    }
    auto G = new double[][](N+2, N+2);
    foreach (i; 0..N+2) {
        foreach (j; i+1..N+2) {
            auto p = PS[i];
            auto q = PS[j];
            auto d = max(0.0, sqrt((p.x - q.x)^^2 + (p.y - q.y)^^2) - p.r - q.r);
            G[i][j] = d;
            G[j][i] = d;
        }
    }

    auto q = priority_queue!("a.d < b.d", Q)();
    foreach (i; 1..N+2) q.enqueue(Q(i, G[0][i]));
    double[] MEMO;
    MEMO.length = N+2;
    foreach (ref m; MEMO) m = 10.0^^20;
    MEMO[0] = 0.0;
    for (;;) {
        auto h = q.dequeue();
        if (h.i == N+1) {
            writefln("%.10f", h.d);
            return;
        }
        foreach (j; 1..N+2) {
            auto d = h.d + G[h.i][j];
            if (d < MEMO[j]) {
                MEMO[j] = d;
                q.enqueue(Q(j, d));
            }
        }
    }
}