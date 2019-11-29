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

struct Solver {

    alias F = PriorityQueue!("a > b", long);
    alias R = PriorityQueue!("a < b", long);

    F front;
    R rear;
    long front_sum;
    long rear_sum;
    long mid;

    this(long x) {
        this.mid = x;
    }

    void add(long x) {
        if (x < this.mid) {
            this.front.enqueue(x);
            this.front_sum += x;
        } else {
            this.rear.enqueue(x);
            this.rear_sum += x;
        }

        if (this.front.length > this.rear.length) {
            this.rear.enqueue(this.mid);
            this.rear_sum += this.mid;
            this.mid = this.front.dequeue();
            this.front_sum -= this.mid;
        } else if (this.front.length+1 < this.rear.length) {
            this.front.enqueue(this.mid);
            this.front_sum += this.mid;
            this.mid = this.rear.dequeue();
            this.rear_sum -= this.mid;
        }
    }

    long query() {
        return mid * this.front.length - this.front_sum + this.rear_sum - this.mid * this.rear.length;
    }
}

void main()
{
    auto Q = readln.chomp.to!int;
    auto q = readln.split.to!(long[]);
    auto solver = Solver(q[1]);
    auto b = q[2];
    foreach (_; 0..Q-1) {
        q = readln.split.to!(long[]);
        if (q[0] == 1) {
            solver.add(q[1]);
            b += q[2];
        } else {
            writefln("%d %d", solver.mid, solver.query() + b);
        }
    }
}