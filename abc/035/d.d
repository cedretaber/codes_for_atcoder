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

alias Path = Tuple!(long, "to", long, "t", long, "min_t");

Path[][10^^5] PS, RS;
long[10^^5] TO, FROM;

void main()
{
    auto nmt = readln.split.to!(long[]);
    auto N = nmt[0];
    auto M = nmt[1];
    auto T = nmt[2];

    auto AS = readln.split.to!(long[]);

    foreach (_; 0..M) {
        auto abc = readln.split.to!(long[]);
        auto a = abc[0]-1;
        auto b = abc[1]-1;
        auto c = abc[2];
        PS[a] ~= Path(b, c, long.max / 4);
        RS[b] ~= Path(a, c, long.max / 4);
    }

    foreach (i; 0..N) {
        TO[i] = long.max / 4;
        FROM[i] = long.max / 4;
    }
    TO[0] = FROM[0] = 0;

    auto Q = priority_queue!"a.t < b.t"([Path(0, 0, 0)]);
    while (!Q.empty) {
        auto top = Q.dequeue();
        foreach (ref p; PS[top.to]) {
            if (p.to && p.min_t > top.min_t + p.t) {
                if (TO[p.to] > top.min_t + p.t) TO[p.to] = top.min_t + p.t;
                p = Path(p.to, p.t, top.min_t + p.t);
                Q.enqueue(p);
            }
        }
    }
    Q = priority_queue!"a.t < b.t"([Path(0, 0, 0)]);
    while (!Q.empty) {
        auto top = Q.dequeue();
        foreach (ref p; RS[top.to]) {
            if (p.to && p.min_t > top.min_t + p.t) {
                if (FROM[p.to] > top.min_t + p.t) FROM[p.to] = top.min_t + p.t;
                p = Path(p.to, p.t, top.min_t + p.t);
                Q.enqueue(p);
            }
        }
    }
    long max_t;
    foreach (i; 0..N) {
        max_t = max(max_t, (T - TO[i] - FROM[i]) * AS[i]);
    }
    writeln(max_t);
}