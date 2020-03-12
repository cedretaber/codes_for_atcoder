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

alias P = Tuple!(int, "i", int, "c");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[] CS, RS;
    foreach (_; 0..N) {
        auto cr = readln.split.to!(int[]);
        CS ~= cr[0];
        RS ~= cr[1];
    }
    int[][] MAP, G;
    MAP.length = N;
    G.length = N;
    foreach (_; 0..K) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        MAP[a] ~= b;
        MAP[b] ~= a;
        G[a] ~= b;
        G[b] ~= a;
    }

    auto memo = new int[](N);
    foreach (i; 0..N) {
        int[] ss = [i];
        foreach (_; 0..RS[i]) {
            int[] nss;
            foreach (j; ss) foreach (k; MAP[j]) if (memo[k] != i+1) {
                memo[k] = i+1;
                G[i] ~= k;
                nss ~= k;
            }
            ss = nss;
        }
    }

    auto pq = priority_queue!("a.c < b.c", P)([P(0, 0)]);
    auto DS = new int[](N);
    DS[] = int.max;
    DS[0] = 0;
    while (!pq.empty) {
        auto h = pq.dequeue();
        foreach (j; G[h.i]) if (DS[j] > h.c + CS[h.i]) {
            DS[j] = h.c + CS[h.i];
            pq.enqueue(P(j, DS[j]));
        }
    }
    writeln(DS[N-1]);
}