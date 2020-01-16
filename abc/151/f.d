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
    auto N = readln.chomp.to!int;
    P[] ps;
    foreach (_; 0..N) {
        auto xy = readln.split.to!(double[]);
        ps ~= P(xy[0], xy[1]);
    }
    bool solve(double r) {
        foreach (i; 0..N-1) {
            foreach (j; i+1..N) {
                auto p = ps[i].middle(ps[j]);
                foreach (k; 0..N) {
                    if (p.dist(ps[k]) > r) goto ng;
                }
                return true;
                ng:
            }
        }
        return false;
    }
    double l = 0, r = 1414.3;
    foreach (_; 0..50) {
        auto m = (l+r)/2;
        if (solve(m)) {
            r = m;
        } else {
            l = m;
        }
    }
    writefln("%.010f", r);
}