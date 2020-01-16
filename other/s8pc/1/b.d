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
}

void main()
{
    auto hwn = readln.split.to!(int[]);
    auto H = hwn[0];
    auto W = hwn[1];
    auto N = hwn[2];
    if (N%2 == 1) {
        writeln(-1);
        return;
    }

    P[] ps;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(double[]);
        ps ~= P(xy[0], xy[1]);
    }

    bool check(P x) {
        int l, r;
        foreach (p; ps) {
            auto det = x.det(p);
            if (det == 0) {
                return false;
            } else if (det > 0) {
                ++l;
            } else {
                ++r;
            }
        }
        return l == r;
    }

    P[] rs;
    foreach (x; 0..W) if (check(P(x, H))) rs ~= P(x, H);
    foreach (y; 0..H) if (check(P(W, y))) rs ~= P(W, y);
    if (check(P(N, N))) rs ~= P(W, H);
    if (rs.empty) {
        writeln(-1);
        return;
    }
    sort!"a.x == b.x ? a.y < b.y : a.x < b.x"(rs);
    foreach (r; rs) {
        writefln("(%d,%d)", r.x.to!int, r.y.to!int);
    }
}