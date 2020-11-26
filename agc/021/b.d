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
enum real EPS = 1e-10;

///
real add(real a, real b) {
    if (abs(a + b) < EPS * (abs(a) + abs(b))) return 0;
    return a + b;
}

///
struct P {
    int i;
    real x, y;

    this(real x, real y) {
        this.x = x;
        this.y = y;
    }

    P opBinary(string op)(P p) {
        static if (op == "+") return P(add(x, p.x), add(y, p.y));
        else static if (op == "-") return P(add(x, -p.x), add(y, -p.y));
        else static assert(0, "Operator '"~op~"' not implemented");
    }

    P opBinary(string op)(real d) {
        static if (op == "*") return P(x * d, y * d);
        else static if (op == "/") return P(x / d, y / d);
        else static assert(0, "Operator '"~op~"' not implemented");
    }

    real norm() {
        return sqrt(add(x^^2, y^^2));
    }

    // dot product
    real dot(P p) {
        return add(x * p.x, y * p.y);
    }

    // cross product
    real det(P p) {
        return add(x * p.y, -y * p.x);
    }

    real dist(P p) {
        return sqrt((x - p.x)^^2 + (y - p.y)^^2);
    }

    P middle(P p) {
        return P((x + p.x)/2, (y + p.y)/2);
    }

    P rotate(real th) {
        return P(add(x * cos(th), -y * sin(th)), add(x * sin(th), y * cos(th)));
    }

    P rotate(P p, real th) {
        auto q = P(x - p.x, y - p.y).rotate(th);
        return P(q.x + p.x, q.y + p.y);
    }
}

P[] convex_hull(P[] ps)
{
    auto n = ps.length;
    sort!"a.x == b.x ? a.y < b.y : a.x < b.x"(ps);
    size_t k;
    auto qs = new P[](n*2);

    foreach (i; 0..n) {
        while (k > 1 && (qs[k-1] - qs[k-2]).det(ps[i] - qs[k-1]) < 0) k--;
        qs[k++] = ps[i];
    }

    auto t = k;
    foreach_reverse (i; 0..n-1) {
        while (k > t && (qs[k-1] - qs[k-2]).det(ps[i] - qs[k-1]) < 0) k--;
        qs[k++] = ps[i];
    }

    qs.length = k - 1;
    return qs;
}

bool on_seg(P p1, P p2, P q) {
    return (p1 - q).det(p2 - q) == 0 && (p1 - q).dot(p2 - q) <= 0;
}

void main()
{
    int N; get(N);
    P[] ps;
    foreach (i; 0..N) {
        real x, y; get(x, y);
        auto p = P(x, y);
        p.i = i;
        ps ~= p;
    }

    if (N == 2) {
        writeln("0.5\n0.5");
        return;
    }

    foreach (p; ps) {
        foreach (q; ps) {
            foreach (r; ps) {
                if (add(add(p.x, q.x) * add(p.y, r.y), -add(p.y, q.y) * add(p.x, r.x)) > 0) goto not_on_a_line;
            }
        }
    }
    {
        sort!"a.x == b.x ? a.y < b.y : a.x < b.x"(ps);
        auto res = new real[](N);
        res[] = 0;
        res[ps[0].i] = 0.5;
        res[ps[$-1].i] = 0.5;
        writefln!"%(%.12f\n%)"(res);
        return;
    }

    not_on_a_line:
    
    ps = convex_hull(ps);
    auto res = new real[](N);
    res[] = 0;
    foreach (i, p; ps) {
        auto o = i == 0 ? ps[$-1] : ps[i-1];
        o.x -= p.x;
        o.y -= p.y;
        auto q = i+1 == ps.length ? ps[0] : ps[i+1];
        q.x -= p.x;
        q.y -= p.y;
        
        auto r = acos(o.dot(q) / o.norm / q.norm);
        auto x = (PI - r) / (2 * PI);
        res[p.i] = x;
    }
    writefln!"%(%.12f\n%)"(res);
}