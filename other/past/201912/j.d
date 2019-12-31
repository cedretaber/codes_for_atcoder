import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii;

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


alias P = Tuple!(int, "h", int, "w", long, "c");

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    long[][] AS;
    AS.length = H;
    foreach (i; 0..H) AS[i] = readln.split.to!(long[]);

    auto MAP = new long[][][](3, H, W);
    foreach (ref mapp; MAP) foreach (ref map; mapp) map[] = long.max/3;

    foreach (i, s; [[H-1, 0], [H-1, W-1], [0, W-1]]) {
        MAP[i][s[0]][s[1]] = 0;
        auto PQ = priority_queue!("a.c < b.c", P)();
        PQ.enqueue(P(s[0], s[1], 0));
        while (!PQ.empty) {
            auto p = PQ.dequeue();
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto h = p.h + d[0];
                auto w = p.w + d[1];
                if (h < 0 || h >= H || w < 0 || w >= W) continue;
                auto c = p.c + AS[h][w];
                if (MAP[i][h][w] <= c) continue;
                MAP[i][h][w] = c;
                PQ.enqueue(P(h, w, c));
            }
        }
    }

    long r = long.max;
    foreach (h; 0..H) foreach (w; 0..W) r = min(r, MAP[0][h][w] + MAP[1][h][w] + MAP[2][h][w] - AS[h][w]*2);
    writeln(r);
}