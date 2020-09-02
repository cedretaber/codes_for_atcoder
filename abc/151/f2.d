import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

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

///
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
    auto N = readln.chomp.to!int;
    P[] ps;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(double[]);
        ps ~= P(xy[0], xy[1]);
    }

    double min_r = 2000;
    foreach (i; 0..N) foreach (j; i+1..N) {
        auto c = Circle(ps[i].middle(ps[j]), ps[i].dist(ps[j]) / 2);
        if (ps.all!(p => c.is_include(p))) min_r = min(min_r, c.r);
    }
    foreach (i; 0..N) foreach (j; i+1..N) foreach (k; j+1..N) {
        auto c = Triangle(ps[i], ps[j], ps[k]).enclosing_circle;
        if (ps.all!(p => c.is_include(p))) min_r = min(min_r, c.r);
    }

    writefln!"%.12f"(min_r);
}