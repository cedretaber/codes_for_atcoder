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

alias Node = Tuple!(int, "i", long, "c");

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
    
    auto MAP = new long[](N);
    int[] ks;
    foreach (_; 0..K) {
        auto c = readln.chomp.to!int - 1;
        MAP[c] = 2;
        ks ~= c;
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
        int[] nks;
        foreach (k; ks) {
            foreach (s; G[k]) if (MAP[s] == 0) {
                MAP[s] = 1;
                nks ~= s;
            }
        }
        ks = nks;
    }
    foreach (ref c; MAP) c = c == 0 ? P : c == 1 ? Q : -1;
    MAP[0] = 0;
    MAP[N-1] = 0;

    auto MIN = new long[](N);
    MIN[] = long.max;
    MIN[0] = 0;
    auto PQ = priority_queue!("a.c < b.c", Node)([Node(0, 0)]);
    for (;;) {
        auto t = PQ.dequeue();
        foreach (n; G[t.i]) if (MAP[n] != -1) {
            if (n == N-1) {
                writeln(t.c);
                return;
            }
            auto c = t.c + MAP[n];
            if (MIN[n] <= c) continue;
            MIN[n] = c;
            PQ.enqueue(Node(n, c));
        }
    }
}