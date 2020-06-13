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

alias P = Tuple!(int, "to", long, "t");

void main()
{
    auto nmsd = readln.split.to!(int[]);
    auto N = nmsd[0];
    auto M = nmsd[1];
    auto s = nmsd[2]-1;
    auto d = nmsd[3]-1;

    long[] AS, BS, CS;
    foreach (_; 0..N) {
        auto abc = readln.split.to!(long[]);
        AS ~= abc[0];
        BS ~= abc[1];
        CS ~= abc[2];
    }

    auto G = new P[][N];
    foreach (_; 0..M) {
        auto xyt = readln.split.to!(int[]);
        auto x = xyt[0]-1;
        auto y = xyt[1]-1;
        long t = xyt[2];

        G[x] ~= P(y, t);
        G[y] ~= P(x, t);
    }

    auto DP = new long[](N);
    DP[] = long.max;
    DP[s] = CS[s];
    auto Q = priority_queue!"a.t < b.t"([P(s, CS[s])]);
    while (!Q.empty) {
        auto h = Q.dequeue();
        if (DP[h.to] < h.t) continue;
        auto i = h.to;
        auto t = h.t;
        auto c = CS[i];
        if (t <= c) {
            t = c;
        } else {
            auto a = AS[i];
            auto b = BS[i];
            auto tt = (t - c) % (a + b);
            if (tt >= a) {
                auto tn = (t - c) / (a + b) + 1;
                t = c + (a + b) * tn;
            }
        }
        foreach (n; G[i]) if (DP[n.to] > t + n.t) {
            DP[n.to] = t + n.t;
            Q.enqueue(P(n.to, t + n.t));
        }
    }
    writeln(DP[d]);
}