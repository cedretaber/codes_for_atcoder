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

alias R = Tuple!(int, "a", int, "b", int, "y");
alias P = Tuple!(int, "i", int, "v", int, "w");

void main()
{
    int N, M, Q; get(N, M);
    R[] rs;
    foreach (_; 0..M) {
        int a, b, y; get(a, b, y);
        rs ~= R(a-1, b-1, y);
    }
    sort!"a.y > b.y"(rs);
    get(Q);
    P[] ps;
    foreach (i; 0..Q) {
        int v, w; get(v, w);
        ps ~= P(i, v-1, w);
    }
    sort!"a.w > b.w"(ps);

    auto uft = Dsu(N);
    auto res = new int[](Q);
    foreach (p; ps) {
        while (!rs.empty && rs.front.y > p.w) {
            uft.merge(rs.front.a, rs.front.b);
            rs.popFront();
        }
        res[p.i] = uft.size(p.v);
    }
    writefln!"%(%d\n%)"(res);
}