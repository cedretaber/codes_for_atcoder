import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

///
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

alias P = Tuple!(int, "to", long, "a", long, "b");
alias T = Tuple!(int, "i", long, "b", long, "s");

void main()
{
    auto nms = readln.split.to!(int[]);
    auto N = nms[0];
    auto M = nms[1];
    long S = nms[2];

    P[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto uvab = readln.split.to!(int[]);
        auto u = uvab[0]-1;
        auto v = uvab[1]-1;
        long A = uvab[2];
        long B = uvab[3];
        G[u] ~= P(v, A, B);
        G[v] ~= P(u, A, B);
    }
    long[] CS, DS;
    foreach (_; 0..N) {
        auto cd = readln.split.to!(long[]);
        CS ~= cd[0];
        DS ~= cd[1];
    }

    auto S_MAX = (N-1)*50;
    auto DP = new long[][](N, S_MAX+1);
    S = min(S, S_MAX);
    foreach (ref dp; DP) dp[] = long.max/3;
    DP[0][S] = 0;

    auto pq = priority_queue!("a.b == b.b ? a.s > b.s : a.b < b.b", T)([T(0, 0, S)]);
    while (!pq.empty) {
        auto h = pq.dequeue();
        auto i = h.i;
        auto s = h.s;
        auto b = h.b;
        if (DP[i][s] < b) continue;
        do {
            foreach (p; G[i]) {
                auto j = p.to;
                if (s < p.a) continue;
                if (DP[j][s-p.a] <= b+p.b) continue;
                DP[j][s-p.a] = b+p.b;
                pq.enqueue(T(j, b+p.b, s-p.a));
            }
            s += CS[i];
            b += DS[i];
        } while (s < S_MAX);
    }
    foreach (i; 1..N) {
        long b_min = long.max;
        foreach (b; DP[i]) b_min = min(b_min, b);
        writeln(b_min);
    }
}