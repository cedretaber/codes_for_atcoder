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

alias Path = Tuple!(int, "to", long, "d", long, "t");
alias Point = Tuple!(int, "i", uint, "s", long, "t");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    Path[][] MAP;
    MAP.length = N;
    foreach (_; 0..M) {
        auto stdt = readln.split.to!(long[]);
        auto s = stdt[0].to!int-1;
        auto t = stdt[1].to!int-1;
        auto d = stdt[2];
        auto time = stdt[3];
        MAP[s] ~= Path(t, d, time);
        MAP[t] ~= Path(s, d, time);
    }

    auto DIST = new long[][](N, 1<<N);
    auto CNT = new long[][](N, 1<<N);
    foreach (ref dp; DIST) dp[] = long.max/3;
    DIST[0][0] = 0;
    CNT[0][0] = 1;
    auto pq = priority_queue!("a.t < b.t", Point)([Point(0, 0, 0)]);
    while (!pq.empty) {
        auto h = pq.dequeue();
        if (DIST[h.i][h.s] != h.t) continue;
        
        foreach (n; MAP[h.i]) {
            auto s = h.s | (1<<n.to);
            if (h.s == s) continue;

            auto t = h.t + n.d;
            if (t > n.t) continue;

            if (DIST[n.to][s] > t) {
                CNT[n.to][s] = 0;
                DIST[n.to][s] = t;
                pq.enqueue(Point(n.to, s, t));
            }
            if (DIST[n.to][s] == t) CNT[n.to][s] += CNT[h.i][h.s];
        }
    }
    if (CNT[0][(1<<N)-1] == 0) {
        writeln("IMPOSSIBLE");
    } else {
        writefln("%d %d", DIST[0][(1<<N)-1], CNT[0][(1<<N)-1]);
    }
}