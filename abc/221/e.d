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

enum P = 998244353L;

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
            (data[p - 1] += cast(U) x) %= P;
            p += p & -p;
        }
    }

    T sum(int l, int r) @safe nothrow @nogc
    {
        assert(0 <= l && l <= r && r <= _n);
        return (sum(r) - sum(l) + P) % P;
    }

private:
    int _n;
    U[] data;

    U sum(int r) @safe nothrow @nogc
    {
        U s = 0;
        while (r > 0)
        {
            (s += data[r - 1]) %= P;
            r -= r & -r;
        }
        return s;
    }
}

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long inv(long x)
{
    return pow(x, P - 2);
}

void main()
{
    int N; get(N);
    int[] AA; get(AA);

    alias A = Tuple!(int, "i", int, "n");
    A[] aa;
    foreach (i; 0..N) aa ~= A(i, AA[i]);
    sort!"a.n == b.n ? a.i > b.i : a.n > b.n"(aa);

    auto len = FenwickTree!long(N);
    auto cs = FenwickTree!long(N);
    long res;
    foreach (a; aa) {
        auto c = cs.sum(a.i, N);
        if (c) (res += len.sum(a.i, N) * inv(pow(2, a.i + 1)) % P) %= P;
        len.add(a.i, pow(2, a.i));
        cs.add(a.i, 1);
    }
    writeln(res);
}
