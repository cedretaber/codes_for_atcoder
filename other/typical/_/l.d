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
    this(long n) @safe nothrow
    {
        _n = cast(int) n, parent_or_size = new int[](n);
        parent_or_size[] = -1;
    }

    int merge(long a, long b) @safe nothrow @nogc
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

    bool same(long a, long b) @safe nothrow @nogc
    {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        return leader(a) == leader(b);
    }

    int leader(long a) @safe nothrow @nogc
    {
        assert(0 <= a && a < _n);
        if (parent_or_size[a] < 0)
            return cast(int) a;
        return parent_or_size[a] = leader(parent_or_size[a]);
    }

    int size(long a) @safe nothrow @nogc
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
    int H, W; get(H, W);
    auto rs = new bool[][](H, W);
    auto uft = Dsu(H * W);
    int Q; get(Q); while (Q--) {
        int[] qq; get(qq);
        if (qq[0] == 1) {
            auto i = qq[1] - 1;
            auto j = qq[2] - 1;
            rs[i][j] = true;
            static foreach (d; [[0,1], [1,0], [0,-1], [-1,0]]) {{
                auto ii = i + d[0];
                auto jj = j + d[1];
                if (0 <= ii && ii < H && 0 <= jj && jj < W && rs[ii][jj]) uft.merge(i * W + j, ii * W + jj);
            }}
        } else {
            auto ia = qq[1] - 1;
            auto ja = qq[2] - 1;
            auto ib = qq[3] - 1;
            auto jb = qq[4] - 1;
            writeln(rs[ia][ja] && rs[ib][jb] && uft.same(ia * W + ja, ib * W + jb) ? "Yes" : "No");
        }
    }
}
