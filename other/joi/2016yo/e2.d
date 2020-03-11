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

alias Path = Tuple!(int, "i", long, "d");

void main()
{
    auto nmks = readln.split.to!(int[]);
    auto N = nmks[0];
    auto M = nmks[1];
    auto K = nmks[2];
    auto S = nmks[3];
    auto pq = readln.split.to!(long[]);
    auto P = pq[0];
    auto Q = pq[1];

    auto MAP = new int[](N);
    int[] cs;
    foreach (_; 0..K) {
        auto c = readln.chomp.to!int-1;
        cs ~= c;
        MAP[c] = 2;
    }
    int[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        G[a] ~= b;
        G[b] ~= a;
    }

    foreach (_; 0..S) {
        int[] ncs;
        foreach (c; cs) foreach (i; G[c]) if (MAP[i] == 0) {
            MAP[i] = 1;
            ncs ~= i;
        }
        cs = ncs;
    }

    auto C = [P, Q, long.max/2];
    auto DS = new long[](N);
    DS[] = long.max/3;
    auto pyq = priority_queue!("a.d < b.d", Path)([Path(0, 0)]);
    while (!pyq.empty) {
        auto h = pyq.dequeue();
        foreach (n; G[h.i]) if (DS[n] > h.d + C[MAP[n]]) {
            DS[n] = h.d + C[MAP[n]];
            pyq.enqueue(Path(n, h.d + C[MAP[n]]));
        }
    }
    writeln(DS[N-1] - C[MAP[N-1]]);
}