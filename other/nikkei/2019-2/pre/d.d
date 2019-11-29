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

alias P = Tuple!(int, "p", long, "c", long, "max_c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ps = new P[](M);
    P[][] G;
    G.length = N;
    foreach (i; 1..N) G[i] ~= P(i-1, 0, long.max);
    foreach (i; 0..M) {
        auto lrc = readln.split.to!(int[]);
        auto l = lrc[0]-1;
        auto r = lrc[1]-1;
        long c = lrc[2];
        G[l] ~= P(r, c, long.max);
    }

    auto Q = priority_queue!("a.max_c < b.max_c", P)([P(0, 0, 0)]);
    long res = -1;
    while (!Q.empty) {
        auto p = Q.dequeue();
        foreach (ref r; G[p.p]) if (r.max_c > p.max_c + r.c) {
            r.max_c = p.max_c + r.c;
            if (r.p == N-1) {
                if (res == -1) {
                    res = r.max_c;
                } else {
                    res = min(res, r.max_c);
                }
            }
            Q.enqueue(r);
        }
    }
    writeln(res);
    return;
}