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

alias K = Tuple!(int, "t", int, "n", long, "c", bool, "d");

void main()
{
    auto S = readln.chomp;
    int t, k = 5;
    long c, r;
    auto Q = priority_queue!("a.t < b.t", K)([]);
    foreach (i; 0..(S.length).to!int*2+10) {
        if (t > 0) --t;
        if (i%2 == 0 && i/2 < S.length && t == 0) {
            auto o = S[i/2];
            if (o == 'N' && k >= 1) {
                k -= 1;
                Q.enqueue(K(i+3, 1, c, false));
            } else if (o == 'C' && k >= 3) {
                k -= 3;
                Q.enqueue(K(i+7, 3, c, false));
                t = 5;
            }
        }

        while (!Q.empty && Q.front.t == i) {
            auto h = Q.dequeue();
            if (h.d) {
                k += h.n;
            } else if (h.n == 1) {
                r += 10L + 1L * (h.c/10L);
                Q.enqueue(K(i+10, 1, c, true));
                c += 1;
            } else {
                r += 50L + 5L * (h.c/10L);
                Q.enqueue(K(i+10, 3, c, true));
                c += 1;
            }
        }
    }
    writeln(r);
}