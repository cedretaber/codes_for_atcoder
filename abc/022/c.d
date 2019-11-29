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

alias R = Tuple!(int, "to", long, "l", long, "min_l");

R[][300] RS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (_; 0..M) {
        auto uvl = readln.split;
        auto U = uvl[0].to!int-1;
        auto V = uvl[1].to!int-1;
        auto L = uvl[2].to!long;
        RS[U] ~= R(V, L, 0);
        RS[V] ~= R(U, L, 0);
    }

    long solve(int start) {
        foreach (ref rs; RS) foreach (ref r; rs) r.min_l = long.max;
        auto Q = priority_queue!("a.min_l < b.min_l", R)();
        foreach (ref r; RS[start]) if (r.to != 0) {
            r.min_l = r.l;
            Q.enqueue(r);
            foreach (ref rr; RS[r.to]) if (rr.to == start) rr.min_l = 0;
        }

        while (!Q.empty) {
            auto head = Q.dequeue();
            if (head.to == 0) return head.min_l;
            foreach (ref next; RS[head.to]) {
                if (next.min_l <= next.l + head.min_l) continue;
                next.min_l = next.l + head.min_l;
                Q.enqueue(next);
            }
        }

        return -1;
    }

    long r = long.max;
    foreach (s; RS[0]) {
        auto t = solve(s.to);
        if (t != -1) r = min(r, t + s.l);
    }
    writeln(r == long.max ? -1 : r);
}