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

enum P = 998244353L;

void main()
{
    long[51] F;
    F[0] = 1;
    foreach (long i; 1..51) F[i] = F[i-1] * i % P;

    int N, K; get(N, K);
    int[][] aa; get_lines(N, aa);

    auto H = Dsu(N);
    auto W = Dsu(N);
    foreach (i; 0..N) {
        int x, y;
        foreach (j; 0..N) if (i != j) {
            bool a = false, b = false;
            foreach (k; 0..N) {
                a = a || (aa[i][k] + aa[j][k] > K);
                b = b || (aa[k][i] + aa[k][j] > K);
            }
            if (!a) H.merge(i, j);
            if (!b) W.merge(i, j);
        }
    }
    long r = 1;
    foreach (g; H.groups()) (r *= F[g.length]) %= P;
    foreach (g; W.groups()) (r *= F[g.length]) %= P;
    writeln(r);
}

/*

3 2 7
4 8 9
1 6 5

2! * 3! = 12

2 3 7
8 4 9
6 1 5

6 1 5
8 4 9
2 3 7

1 6 5
4 8 9
3 2 7

6 1 5
8 4 9
2 3 7



1 2
3 4

3 4
1 2

2 1
4 3

4 3
2 1

*/