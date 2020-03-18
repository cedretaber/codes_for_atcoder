import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum EPS = 1e-10;

double add(double a, double b) {
    if (abs(a + b) < EPS * (abs(a) + abs(b))) return 0;
    return a + b;
}

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
        return P(x * cos(th) - y * sin(th), x * sin(th) + y * cos(th));
    }

    P rotate(P p, double th) {
        auto q = P(x - p.x, y - p.y).rotate(th);
        return P(q.x + p.x, q.y + p.y);
    }
}

P[] circle_intersection(P p1, double r1, P p2, double r2) {
    if (add(p1.dist(p2), -add(r1, r2)) == 0) return [p1.middle(p2)];
    auto th = atan2(p2.y - p1.y, p2.x - p1.x);
    auto len = p1.dist(p2) * r1 / add(r1, r2);
    auto h = sqrt(add(r1^^2, -len^^2));
    return [P(add(p1.x, len), add(p1.y, h)).rotate(p1, th), P(add(p1.x, len), add(p1.y, -h)).rotate(p1, th)];
}

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    P[] ps;
    double[] cs;
    foreach (_; 0..N) {
        auto xyc = readln.split.to!(double[]);
        ps ~= P(xyc[0], xyc[1]);
        cs ~= xyc[2];
    }

    double l = 0, r = 100*2*1000;
    foreach (_; 0..100) {
        auto m = (l+r)/2;

        P[] iss;
        iss ~= ps;
        foreach (i; 0..N-1) {
            foreach (j; i+1..N) {
                auto r1 = m/cs[i], r2 = m/cs[j];
                if (ps[i].dist(ps[j]) < add(r1, r2) + EPS) {
                    iss ~= circle_intersection(ps[i], r1, ps[j], r2);
                }
            }
        }

        foreach (q; iss) {
            int k;
            foreach (i, p; ps) {
                if (p.dist(q) * cs[i] < m + EPS) ++k;
            }
            if (k >= K) {
                r = m;
                goto ok;
            }
        }
        l = m;
        ok:
    }

    writefln("%.10f", r);
}