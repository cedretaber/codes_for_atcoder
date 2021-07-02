import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

///
enum EPS = 1e-10;

///
pure nothrow
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

    P opOpAssign(string op)(P p) {
        static if (op == "+") {
            this.x = add(this.x, p.x);
            this.y = add(this.y, p.y);
            return this;
        } else static if (op == "-") {
            this.x = add(this.x, -p.x);
            this.y = add(this.y, -p.y);
            return this;
        } else static assert(0, "Operator '"~op~"' not implemented");
    }

    P opBinary(string op)(P p) {
        P q = this;
        return q.opOpAssign!op(p);
    }

    P opOpAssign(string op)(double d) {
        static if (op == "*") {
            this.x = this.x * d;
            this.y = this.y * d;
            return this;
        } else static if (op == "/") {
            this.x = this.x / d;
            this.y = this.y / d;
            return this;
        } else static assert(0, "Operator '"~op~"' not implemented");
    }

    P opBinary(string op)(double d) {
        P q = this;
        return q.opOpAssign!op(d);
    }

    bool opEquals(const P p) {
        return abs(x - p.x) <= EPS && abs(y - p.y) <= EPS;
    }

    @property nothrow pure
    double norm() {
        return sqrt(add(x^^2, y^^2));
    }

    @property nothrow pure
    double declination() {
        return atan2(y, x);
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

P[] arrange(P[] ps) {
    double x = 0, y = 0;
    foreach (p; ps) {
        x += p.x;
        y += p.y;
    }
    auto s = P(x / ps.length, y / ps.length);

    P[] qs;
    foreach (p; ps) {
        auto q = P(p.x - s.x, p.y - s.y);
        if (abs(q.x) > EPS || abs(q.y) > EPS) qs ~= q;
    }
    return qs;
}

alias decl_sort = sort!((a, b) {
    auto at = a.declination;
    auto bt = b.declination;
    if (abs(at - bt) < EPS) return a.norm < b.norm;
    return at < bt;
}, SwapStrategy.unstable, P[]);

void main()
{
    int N; get(N);
    P[] SS, TT;
    foreach (_; 0..N) {
        double x, y; get(x, y);
        SS ~= P(x, y);
    }
    foreach (_; 0..N) {
        double x, y; get(x, y);
        TT ~= P(x, y);
    }

    if (N == 1) return writeln("Yes");

    auto ss = arrange(SS);
    auto th = ss[0].declination;
    foreach (ref s; ss) s = s.rotate(-th);
    decl_sort(ss);

    auto tt = arrange(TT);
    if (ss.length != tt.length) return writeln("No");
    foreach (i; 0..tt.length) {
        th = tt[i].declination;
        P[] uu;
        foreach (t; tt) uu ~= t.rotate(-th);
        decl_sort(uu);
        if (ss == uu) return writeln("Yes");
    }

    writeln("No");
}
