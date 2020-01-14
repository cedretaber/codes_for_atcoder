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

alias TA = Tuple!(long, "t", long, "a");

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto X = nx[1];
    auto ts = readln.split.to!(long[]);
    auto as = readln.split.to!(long[]);
    auto tas = new TA[](N);
    foreach (i; 0..N) {
        tas[i] = TA(ts[i], as[i]);
    }
    sort!"a.t > b.t"(tas);

    bool solve(long t) {
        auto Q = priority_queue!("a.a > b.a", TA)();
        size_t i;
        while (i < N && tas[i].t >= t) Q.enqueue(tas[i++]);
        long x;
        foreach_reverse (j; 0..t) {
            if (!Q.empty) {
                x += Q.dequeue().a;
            }
            while (i < N && tas[i].t >= j) Q.enqueue(tas[i++]);
        }
        return x >= X;
    }

    if (!solve(10^^5)) {
        writeln(-1);
        return;
    }

    long l, r = 10^^5;
    while (l+1 < r) {
        auto m = (l+r)/2;
        if (solve(m)) {
            r = m;
        } else {
            l = m;
        }
    }
    writeln(r);
}