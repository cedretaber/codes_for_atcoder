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

void main()
{
    int N; get(N);
    long[] AA, BB; get(AA); get(BB);
    if (AA.sum() != BB.sum()) return writeln(-1);
    
    int[][long] ii;
    foreach (i, a; AA) ii[a + i] ~= i.to!int;
    auto ft = FenwickTree!long(N);
    long r;
    foreach (i, b; BB) {
        if (b + i !in ii || ii[b + i].empty) return writeln(-1);
        auto j = ii[b + i].front;
        ii[b + i].popFront();
        r += j - ft.sum(0, j);
        ft.add(j, 1);
    }
    writeln(r);
}

/*

6
8 5 4 7 4 5
10 5 6 7 4 1
* * *

10 7 4 3 4 5
10 5 6 7 4 1
   *

10 5 6 3 4 5
10 5 6 7 4 1
       * *

10 5 6 7 2 3
10 5 6 7 4 1
         *

10 5 6 7 4 1
10 5 6 7 4 1


0 1 2 3 4 5

8 6 6 10 8 10

8 5 4 7 4 5
10 5 6 7 4 1

10 6 8 10 8 6


6: 1, 2
8: 0, 4
10: 3, 5




*/
