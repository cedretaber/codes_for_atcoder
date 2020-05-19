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

alias Path = Tuple!(int, "to", long, "c");
enum MAX = long.max/3;

void main()
{
    auto nmt = readln.split.to!(int[]);
    auto N = nmt[0];
    auto M = nmt[1];
    long T = nmt[2];

    auto AS = readln.split.to!(long[]);

    Path[][] G, H;
    G.length = N;
    H.length = N;
    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0]-1;
        auto b = abc[1]-1;
        long c = abc[2];
        G[a] ~= Path(b, c);
        H[b] ~= Path(a, c);
    }

    auto DP1 = new long[](N);
    DP1[] = MAX;
    DP1[0] = 0;
    auto Q = priority_queue!("a < b", Path)([Path(0, 0)]);
    while (!Q.empty) {
        auto h = Q.dequeue();
        if (DP1[h.to] < h.c) continue;
        foreach (n; G[h.to]) {
            if (DP1[n.to] <= h.c + n.c) continue;
            DP1[n.to] = h.c + n.c;
            Q.enqueue(Path(n.to, h.c + n.c));
        }
    }

    auto DP2 = new long[](N);
    DP2[] = MAX;
    DP2[0] = 0;
    Q = priority_queue!("a < b", Path)([Path(0, 0)]);
    while (!Q.empty) {
        auto h = Q.dequeue();
        if (DP2[h.to] < h.c) continue;
        foreach (n; H[h.to]) {
            if (DP2[n.to] <= h.c + n.c) continue;
            DP2[n.to] = h.c + n.c;
            Q.enqueue(Path(n.to, h.c + n.c));
        }
    }

    long r;
    foreach (i, a; AS) {
        if (DP1[i] == MAX || DP2[i] == MAX) continue;
        r = max(r, (T - DP1[i] - DP2[i]) * a);
    }
    writeln(r);
}