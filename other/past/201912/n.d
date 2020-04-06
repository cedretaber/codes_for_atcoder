import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii, core.bitop;

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

alias S = Tuple!(int, "l", int, "r", long, "p");

void main()
{
    auto nwc = readln.split.to!(int[]);
    auto N = nwc[0];
    auto W = nwc[1];
    auto C = nwc[2];
    S[] ss;
    foreach (_; 0..N) {
        auto lrp = readln.split.to!(int[]);
        ss ~= S(lrp[0], lrp[1], lrp[2]);
    }
    sort!"a.l == b.l ? a.r < b.r : a.l < b.l"(ss);

    auto max_rs = new int[](N);
    max_rs[0] = ss[0].r;
    foreach (i; 1..N) max_rs[i] = max(max_rs[i-1], ss[i].r);

    auto ls = new int[](N);
    auto rs = new int[](N);
    foreach (i; 0..N) {
        if (i == 0) {
            ls[i] = 0;
            rs[i] = N == 1 ? W : ss[i+1].l;
        } else if (i == N-1) {
            ls[i] = N == 1 ? 0 : max_rs[i-1];
            rs[i] = W;
        } else {
            ls[i] = max_rs[i-1];
            rs[i] = ss[i+1].l;
        }
    }

    if (ss[0].l >= C || W - max_rs[N-1] >= C) {
        writeln(0);
        return;
    }
    foreach (i; 1..N) if (ss[i].l - max_rs[i-1] >= C) {
        writeln(0);
        return;
    }

    auto cs = new long[](N);
    cs[0] = ss[0].p;
    foreach (i; 1..N) cs[i] = cs[i-1] + ss[i].p;

    auto Q = priority_queue!("a.r < b.r", S)();
    long c, min_c = long.max;
    int min_r;
    foreach (i; 0..N) {
        auto l = ss[i].l;
        c += ss[i].p;
        if (rs[i] - min_r >= C) min_c = min(min_c, c);
        for (;;) {
            if (Q.empty) break;
            auto h = Q.dequeue();
            if (rs[i] - h.r < C) {
                Q.enqueue(h);
                break;
            }
            c -= h.p;
            min_r = h.r;
            min_c = min(min_c, c);
        }
        Q.enqueue(ss[i]);
    }
    while (!Q.empty && W - min_r >= C) {
        min_c = min(min_c, c);
        auto h = Q.dequeue();
        c -= h.p;
        min_r = h.r;
    }
    writeln(min_c);
}