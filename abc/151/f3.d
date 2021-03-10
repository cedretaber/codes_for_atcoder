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

    double norm() {
        return sqrt(add(x^^2, y^^2));
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

struct Circle {
    P p;
    double r;

    this(P p, double r) {
        this.p = p;
        this.r = r;
    }

    bool is_include(P p) {
        return this.p.dist(p) <= this.r;
    }
}

///
struct Triangle {
    P a, b, c;

    this(P a, P b, P c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }

    Circle enclosing_circle() {
        auto A = (b-c).dot(b-c);
        auto B = (c-a).dot(c-a);
        auto C = (a-b).dot(a-b);

        auto T = A*(B+C-A);
        auto U = B*(C+A-B);
        auto W = C*(A+B-C);

        auto p = (a*T + b*U + c*W)/(T + U + W);

        return Circle(p, sqrt((a.x - p.x)^^2 + (a.y - p.y)^^2));
    }

    Circle circumcenter() {
        auto y = (
            (c.x - a.x) * (a.x^^2 + a.y^^2 - b.x^^2 - b.y^^2) - (b.x - a.x) * (a.x^^2 + a.y^^2 - c.x^^2 - c.y^^2)) /
            (2 * (c.x - a.x) * (a.y - b.y) - 2 * (b.x - a.x) * (a.y - c.y));
        auto x = b.x - a.x != 0
            ? (2 * (a.y - b.y) * y - a.x^^2 - a.y^^2 + b.x^^2 + b.y^^2) / (2 * (b.x - a.x))
            : (2 * (a.y - c.y) * y - a.x^^2 - a.y^^2 + c.x^^2 + c.y^^2) / (2 * (c.x - a.x));

        auto p = P(x, y);
        return Circle(p, p.dist(a));
    }
}

void main()
{
    int N; get(N);
    P[] ps;
    foreach (_; 0..N) {
        double x, y; get(x, y);
        ps ~= P(x, y);
    }

    auto res = double.infinity;
    foreach (i; 0..N-1) foreach (j; i+1..N) {
        auto m = ps[i].middle(ps[j]);
        auto c = Circle(m, m.dist(ps[i]));
        if (ps.all!(p => c.is_include(p))) res = min(res, c.r);
    }
    foreach (i; 0..N-2) foreach (j; i+1..N-1) foreach (k; j+1..N) {
        auto t = Triangle(ps[i], ps[j], ps[k]);
        auto c = t.enclosing_circle();
        if (ps.all!(p => c.is_include(p))) res = min(res, c.r);
    }
    writefln!"%.12f"(res);
}
