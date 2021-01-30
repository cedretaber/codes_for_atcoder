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
    int N; get(N);
    int[] aa; get(aa);

    alias P = Tuple!(int, "i", int, "a");
    P[] ps;
    foreach (i, a; aa) ps ~= P(i.to!int, a);
    sort!"a.a < b.a"(ps);
    auto bit = FenwickTree!long(N);
    long res;
    foreach_reverse (p; ps) {
        res += bit.sum(0, p.i);
        bit.add(p.i, 1);
    }
    writeln(res);
    sort!"a.i < b.i"(ps);
    foreach (p; ps[0..$-1]) {
        res += N-p.a-1 - p.a;
        writeln(res);
    }
}

/*

4
0 1 2 3

1 2 3 0

2 3 0 1

3 0 1 2




4
0 1 2 3


10
0 3 1 5 4 2 9 6 8 7
0 0 1 0 1 3 0 1 1 2 => 9

3 1 5 4 2 9 6 8 7 0
0 1 0 1 3 0 1 1 2 9 => 18

1 5 4 2 9 6 8 7 0 3
0 0 1 2 0 1 1 2 8 6 => 



*/