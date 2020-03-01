import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

///
enum EPS = 1.0e-10;

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
}

P[] circle_intersection(P p1, double r1, P p2, double r2) {
    if (add(p1.dist(p2), -add(r1, r2)) == 0) return [p1.middle(p2)];
    auto th = atan2(p2.y - p1.y, p2.x - p1.x);
    auto len = p1.dist(p2) * r1 / add(r1, r2);
    auto h = sqrt(add(r1^^2, -len^^2));
    return [P(add(p1.x, len), add(p1.y, h)).rotate(th), P(add(p1.x, len), add(p1.y, -h)).rotate(th)];
}

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(double[]);
        ps ~= P(xy[0], xy[1]);
    }

    double l = 0, r = 1000;
    foreach (_; 0..100) {
        auto m = (l+r)/2;
        P[] qs;
        foreach (i; 0..N) {
            foreach (j; i+1..N) {
                if (ps[i].dist(ps[j]) <= m*2) {
                    qs ~= circle_intersection(ps[i], m, ps[j], m);
                }
            }
        }
        bool ok;
        foreach (q; qs) {
            foreach (p; ps) {
                if (q.dist(p) > m + EPS) goto ng;
            }
            ok = true;
            goto finish;
            ng:
        }
        finish:
        if (ok) {
            r = m;
        } else {
            l = m;
        }
    }
    writefln("%.10f", r);
}