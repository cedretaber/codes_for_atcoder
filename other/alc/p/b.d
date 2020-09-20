import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

struct FenwickTree(T)
{
    import std.traits : isSigned, Unsigned;

    static if (isSigned!T)
    {
        alias U = Unsigned!T;
    }
    else
    {
        alias U = T;
    }
public:
    this(int n)
    {
        _n = n;
        data = new U[](n);
    }

    void add(int p, T x)
    {
        assert(0 <= p && p < _n);
        p++;
        while (p <= _n)
        {
            data[p - 1] += cast(U) x;
            p += p & -p;
        }
    }

    T sum(int l, int r)
    {
        assert(0 <= l && l <= r && r <= _n);
        return sum(r) - sum(l);
    }

private:
    int _n;
    U[] data;

    U sum(int r)
    {
        U s = 0;
        while (r > 0)
        {
            s += data[r - 1];
            r -= r & -r;
        }
        return s;
    }
}

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];

    auto ft = FenwickTree!long(N);
    foreach (i, a; readln.split.to!(long[])) ft.add(i.to!int, a);
    while (Q--) {
        auto q = readln.split.to!(int[]);
        if (q[0] == 0) {
            ft.add(q[1], q[2]);
        } else {
            writeln(ft.sum(q[1], q[2]));
        }
    }
}