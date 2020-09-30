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
    this(int n) @safe nothrow
    {
        _n = n;
        data = new U[](n);
    }

    void add(int p, T x) @safe nothrow @nogc
    {
        assert(0 <= p && p < _n);
        p++;
        while (p <= _n)
        {
            data[p - 1] += cast(U) x;
            p += p & -p;
        }
    }

    T sum(int l, int r) @safe nothrow @nogc
    {
        assert(0 <= l && l <= r && r <= _n);
        return sum(r) - sum(l);
    }

private:
    int _n;
    U[] data;

    U sum(int r) @safe nothrow @nogc
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

alias P = Tuple!(int, "i", int, "n");

void main()
{
    int N; get(N);
    int[] as; get(as);
    auto ns = as.dup;
    sort(ns);
    ns = ns.uniq().array();
    auto len = N.to!long * (N+1).to!long / 2;
    int l, r = ns.length.to!int;
    while (l+1 < r) {
        auto m = (l+r)/2;
        auto bs = [N];
        foreach (a; as) {
            if (a >= ns[m]) {
                bs ~= 1;
            } else {
                bs ~= -1;
            }
        }
        foreach (i; 1..N+1) bs[i] += bs[i-1];
        auto bit = FenwickTree!int(N*2+1);
        long c;
        foreach (n; bs) {
            c += bit.sum(0, n+1);
            bit.add(n, 1);
        }
        if (c >= len/2) {
            l = m;
        } else {
            r = m;
        }
    }
    writeln(ns[l]);
}

/*

5 9 5 9 8 9 3 5 4 3

x=8
-1 1 -1 1 1 1 -1 -1 -1 -1
-1 0 -1 0 1 2 1 0 -1 -2



10 30 20

x=30
-1 1 -1
-1 0 -1

10 30 20 30 30 20
10 20 20 30 30 30

*/