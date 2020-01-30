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

alias Path = Tuple!(int, "to", long, "c", long, "t");
alias Node = Tuple!(int, "i", int, "j", long, "c", long, "t");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    Path[][] JG;
    JG.length = N;
    JG[0] ~= Path(0, 1, 0);
    foreach (_; 0..M) {
        auto abct = readln.split.to!(int[]);
        auto a = abct[0]-1;
        auto b = abct[1]-1;
        long c = abct[2];
        long t = abct[3];
        JG[a] ~= Path(b, c, t);
        JG[b] ~= Path(a, c, t);
    }
    foreach (i; 0..N) sort!"a.c < b.c"(JG[i]);

    long[][] RR;
    RR.length = N;
    foreach (i; 0..N) {
        RR[i].length = JG[i].length;
        RR[i][] = long.max/3;
    }
    RR[0][0] = 0;

    auto Q = priority_queue!("a.t < b.t", Node)([Node(0, 0, 1, 0)]);
    long ret = long.max;
    while (!Q.empty) {
        auto h = Q.dequeue();
        auto i = h.i;
        auto j = h.j;

        if (i == N-1) {
            ret = min(ret, h.t);
            continue;
        }

        if (j > 0) {
            auto t = h.t + abs(h.c - JG[i][j-1].c);
            if (t < RR[i][j-1]) {
                RR[i][j-1] = t;
                Q.enqueue(Node(i, j-1, JG[i][j-1].c, t));
            }
        }
        {
            auto k = JG[i][j].to;
            auto t = h.t + JG[i][j].t;
            int l, r = JG[k].length.to!int - 1;
            if (JG[k][0].c == h.c) {
                r = 0;
            } else {
                while (l+1 < r) {
                    auto m = (l+r)/2;
                    if (JG[k][m].c < h.c) {
                        l = m;
                    } else {
                        r = m;
                    }
                }
            }
            if (t < RR[k][r]) {
                RR[k][r] = t;
                Q.enqueue(Node(k, r, h.c, t));
            }
        }
        if (j+1 < JG[i].length) {
            auto t = h.t + abs(h.c - JG[i][j+1].c);
            if (t < RR[i][j+1]) {
                RR[i][j+1] = t;
                Q.enqueue(Node(i, j+1, JG[i][j+1].c, t));
            }
        }
    }
    writeln(ret);
}