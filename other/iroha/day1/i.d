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

alias Path = Tuple!(int, "to", int, "c", int, "min_c");
alias Squ = Tuple!(int, "p", int, "l", int, "c");

Path[][10^^5] PS;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];

    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0]-1;
        auto b = abc[1]-1;
        auto c = abc[2];
        PS[a] ~= Path(b, c, int.max);
        PS[b] ~= Path(a, c, int.max);
    }

    Squ[] store;
    foreach (p; PS[0]) {
        store ~= Squ(p.to, p.c, 0);
    }

    import std.container : heapify;
    auto Q = priority_queue!"a.c < b.c"(store);
    while (!Q.empty) {
        auto head = Q.dequeue();
        if (head.p == N-1) {
            writeln(head.c * K + K);
            return;
        }
        foreach (ref p; PS[head.p]) {
            auto c = head.c + (head.l == p.c ? 0 : 1);
            if (c < p.min_c) {
                p.min_c = c;
                Q.enqueue(Squ(p.to, p.c, c));
            }
        }
    }
    writeln("-1");
}