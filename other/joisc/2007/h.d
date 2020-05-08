import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

///
enum EPS = 1e-10;

///
double add(double a, double b) {
    if (abs(a + b) < EPS * (abs(a) + abs(b))) return 0;
    return a + b;
}

///
struct P {
    double x, y;

    this(double x, double y) {
        this.x = x;
        this.y = y;
    }

    P opBinary(string op)(P p) {
        static if (op == "+") return P(add(x, p.x), add(y, p.y));
        else static if (op == "-") return P(add(x, -p.x), add(y, -p.y));
        else static assert(0, "Operator '"~op~"' not implemented");
    }

    P opBinary(string op)(double d) {
        static if (op == "*") return P(x * d, y * d);
        else static if (op == "/") return P(x / d, y / d);
        else static assert(0, "Operator '"~op~"' not implemented");
    }

    // dot product
    double dot(P p) {
        return add(x * p.x, y * p.y);
    }

    // cross product
    double det(P p) {
        return add(x * p.y, -y * p.x);
    }

    double dist(P p) {
        return sqrt((x - p.x)^^2 + (y - p.y)^^2);
    }

    P middle(P p) {
        return P((x + p.x)/2, (y + p.y)/2);
    }

    P rotate(double th) {
        return P(add(x * cos(th), -y * sin(th)), add(x * sin(th), y * cos(th)));
    }

    P rotate(P p, double th) {
        auto q = P(x - p.x, y - p.y).rotate(th);
        return P(q.x + p.x, q.y + p.y);
    }
}

bool is_acute(P a, P b, P c)
{
    a = a - b;
    c = c - b;
    auto r = acos(a.dot(c) / (sqrt(a.x^^2 + a.y^^2) * sqrt(c.x^^2 + c.y^^2))) * (180 / PI);
    return add(r, -90) < 0;
}

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

alias Path = Tuple!(int, "to", long, "c");
alias E = Tuple!(int, "i", int, "p", long, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    P[] ps;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(double[]);
        ps ~= P(xy[0], xy[1]);
    }
    Path[][] G;
    G.length = N;
    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto A = abc[0]-1;
        auto B = abc[1]-1;
        long C = abc[2];
        G[A] ~= Path(B, C);
        G[B] ~= Path(A, C);
    }

    auto DP = new long[][](N, N);
    foreach (ref dp; DP) dp[] = long.max/3;
    DP[0][0] = 0;

    auto Q = priority_queue!("a.c < b.c", E)([E(0, 0, 0)]);
    while (!Q.empty) {
        auto h = Q.dequeue();
        auto i = h.i;
        auto p = h.p;
        auto c = h.c;
        if (i != p && DP[i][p] < c) continue;
        foreach (n; G[i]) if (i == p || !is_acute(ps[p], ps[i], ps[n.to])) {
            auto cc = c + n.c;
            auto j = n.to;
            if (DP[j][i] <= cc) continue;
            DP[j][i] = cc;
            Q.enqueue(E(j, i, cc));
        }
    }

    auto r = long.max/3;
    foreach (d; DP[1]) r = min(r, d);
    writeln(r == long.max/3 ? -1 : r);
}