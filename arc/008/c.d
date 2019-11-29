import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

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

alias P = Tuple!(double, "x", double, "y", double, "t", double, "r");

P[1000] PS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(double[]);
        PS[i] = P(xy[0], xy[1], xy[2], xy[3]);
    }

    auto TS = new double[][](N, N);
    foreach (i; 0..N) {
        foreach (j; i+1..N) {
            auto a = PS[i];
            auto b = PS[j];
            auto d = sqrt((a.x - b.x)^^2 + (a.y - b.y)^^2);
            TS[i][j] = d / min(a.t, b.r);
            TS[j][i] = d / min(a.r, b.t);
        }
    }

    double[] cs;
    cs.length = N;
    cs[0] = 0;
    foreach (ref c; cs[1..$]) c = 1.0/0;

    auto pq = priority_queue!((a, b) => cs[a] < cs[b], int)([0]);
    while (!pq.empty) {
        auto n = pq.dequeue();
        foreach (m; 1..N) if (n != m) {
            auto c = cs[n] + TS[n][m];
            if (cs[m] <= c) continue;
            cs[m] = c;
            pq.enqueue(m);
        }
    }
    sort!"a > b"(cs);
    double r = 0;
    foreach (i, c; cs[0..$-1]) {
        r = max(r, c + i);
    }
    writefln("%.10f", r);
}