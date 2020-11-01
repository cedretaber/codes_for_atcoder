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

struct Dsu
{
public:
    this(int n) @safe nothrow
    {
        _n = n, parent_or_size = new int[](n);
        parent_or_size[] = -1;
    }

    int merge(int a, int b) @safe nothrow @nogc
    {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        int x = leader(a), y = leader(b);
        if (x == y)
            return x;
        if (-parent_or_size[x] < -parent_or_size[y])
        {
            auto tmp = x;
            x = y;
            y = tmp;
        }
        parent_or_size[x] += parent_or_size[y];
        parent_or_size[y] = x;
        return x;
    }

    bool same(int a, int b) @safe nothrow @nogc
    {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        return leader(a) == leader(b);
    }

    int leader(int a) @safe nothrow @nogc
    {
        assert(0 <= a && a < _n);
        if (parent_or_size[a] < 0)
            return a;
        return parent_or_size[a] = leader(parent_or_size[a]);
    }

    int size(int a) @safe nothrow @nogc
    {
        assert(0 <= a && a < _n);
        return -parent_or_size[leader(a)];
    }

    int[][] groups() @safe nothrow
    {
        auto leader_buf = new int[](_n), group_size = new int[](_n);
        foreach (i; 0 .. _n)
        {
            leader_buf[i] = leader(i);
            group_size[leader_buf[i]]++;
        }
        auto result = new int[][](_n);
        foreach (i; 0 .. _n)
            result[i].reserve(group_size[i]);
        foreach (i; 0 .. _n)
            result[leader_buf[i]] ~= i;
        int[][] filtered;
        foreach (r; result)
            if (r.length != 0)
                filtered ~= r;
        return filtered;
    }

private:
    int _n;
    int[] parent_or_size;
}

void main()
{
    int N; get(N);
    P[] ps;
    foreach (_; 0..N) {
        double x, y; get(x, y);
        ps ~= P(x, y);
    }

    double l = 1, r = 200;
    foreach (_; 0..100) {
        auto m = (l+r)/2;

        auto uft = Dsu(N+2);
        foreach (i; 0..N) {
            if (100 - ps[i].y < m) uft.merge(0, i+1);
            if (100 + ps[i].y < m) uft.merge(N+1, i+1);
        }
        foreach (i; 0..N-1) foreach (j; i+1..N) if (ps[i].dist(ps[j]) < m) {
            uft.merge(i+1, j+1);
        }
        if (uft.same(0, N+1)) {
            r = m;
        } else {
            l = m;
        }
    }
    writefln!"%.12f"(l / 2);
}