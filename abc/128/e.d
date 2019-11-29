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

alias T = Tuple!(long, "t", long, "x", char, "st");
T[10^^5*4] TS;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    foreach (i; 0..N) {
        auto stx = readln.split.to!(long[]);
        auto x = stx[2];
        TS[i] = T(stx[0]-x, x, 'S');
        TS[N+i] = T(stx[1]-x, x, 'T');
    }
    sort!"a.t < b.t"(TS[0..N*2]);

    size_t i;
    auto QQ = priority_queue!("a < b", long)();
    auto PP = priority_queue!("a < b", long)();
    foreach (_; 0..Q) {
        auto D = readln.chomp.to!long;

        while (i < N*2 && TS[i].t <= D) {
            if (TS[i].st == 'S') {
                QQ.enqueue(TS[i].x);
            } else {
                if (QQ.front == TS[i].x) {
                    QQ.dequeue();
                    while (!PP.empty && !QQ.empty && QQ.front == PP.front) {
                        PP.dequeue();
                        QQ.dequeue();
                    }
                } else {
                    PP.enqueue(TS[i].x);
                }
            }
            ++i;
        }

        if (QQ.empty) {
            writeln("-1");
        } else {
            writeln(QQ.front);
        }
    }
}