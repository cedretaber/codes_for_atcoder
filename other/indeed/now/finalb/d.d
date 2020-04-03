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

alias P = Tuple!(int, "x", int, "y", long, "p");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto xy = readln.split.to!(int[]);
    auto x = xy[0]-1;
    auto y = xy[1]-1;
    readln;
    auto B = new long[][](H, W);
    long r;
    foreach (i; 0..H) {
        foreach (j, p; readln.split.to!(long[])) {
            r += p;
            B[i][j] = p;
        }
    }
    auto pq = priority_queue!("a.p > b.p", P)([P(x, y, 0)]);
    auto F = new bool[][](H, W);
    while (!pq.empty) {
        auto h = pq.dequeue();
        if (F[h.y][h.x]) continue;
        F[h.y][h.x] = true;
        r += h.p;
        foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
            x = h.x + d[0];
            y = h.y + d[1];
            if (x < 0 || x >= W || y < 0 || y >= H || F[y][x]) continue;
            pq.enqueue(P(x, y, B[h.y][h.x] * B[y][x]));
        }
    }
    writeln(r);
}