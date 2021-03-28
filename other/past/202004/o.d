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
    this(int n)
    {
        _n = n, parent_or_size = new int[](n);
        parent_or_size[] = -1;
    }

    int merge(int a, int b)
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

    bool same(int a, int b)
    {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        return leader(a) == leader(b);
    }

    int leader(int a)
    {
        assert(0 <= a && a < _n);
        if (parent_or_size[a] < 0)
            return a;
        return parent_or_size[a] = leader(parent_or_size[a]);
    }

    int size(int a)
    {
        assert(0 <= a && a < _n);
        return -parent_or_size[leader(a)];
    }

    int[][] groups()
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


alias E = Tuple!(int, "i", int, "a", int, "b", long, "c", bool, "f");
alias P = Tuple!(int, "to", long, "c");

void main()
{
    int N, M; get(N, M);
    E[] ES;
    foreach (i; 0..M) {
        int A, B; long C; get(A, B, C); --A; --B;
        ES ~= E(i, A, B, C, false);
    }

    sort!"a.c < b.c"(ES);
    auto uft = Dsu(N);
    auto T = new P[][N];
    long c_sum;
    foreach (ref e; ES) with (e) {
        if (uft.same(a, b)) continue;
        f = true;
        c_sum += c;
        uft.merge(a, b);
        T[a] ~= P(b, c);
        T[b] ~= P(a, c);
    }

    auto ps = new int[][](N, 20);
    auto cs = new long[][](N, 20);
    auto ds = new int[](N);
    void walk(int i, int p, int d, long c) {
        ps[i][0] = p;
        cs[i][0] = c;
        ds[i] = d;
        foreach (n; T[i]) if (n.to != p) walk(n.to, i, d + 1, n.c);
    }
    walk(0, 0, 0, 0);
    foreach (k; 1..20) foreach (i; 0..N) {
        auto j = ps[i][k - 1];
        ps[i][k] = ps[j][k - 1];
        cs[i][k] = max(cs[i][k - 1], cs[j][k - 1]);
    }

    auto res = new long[](M);
    foreach (e; ES) with (e) {
        if (f) {
            res[i] = c_sum;
            continue;
        }

        if (ds[a] > ds[b]) swap(a, b);
        auto d = ds[b] - ds[a];
        long max_c;
        foreach (j; 0..20) if (d & (1<<j)) {
            max_c = max(max_c, cs[b][j]);
            b = ps[b][j];
        }

        if (a == b) {
            res[i] = c_sum - max_c + c;
            continue;
        } else if (ps[a][0] == ps[b][0]) {
            max_c = max(max_c, cs[a][0], cs[b][0]);
            res[i] = c_sum - max_c + c;
            continue;
        }

        int l, r = ds[a];
        while (l + 1 < r) {
            auto m = (l + r) / 2;
            auto aa = a, bb = b;
            foreach (j; 0..20) if (m & (1<<j)) {
                aa = ps[aa][j];
                bb = ps[bb][j];
            }
            if (aa == bb) {
                r = m;
            } else {
                l = m;
            }
        }

        foreach (j; 0..20) if (r & (1<<j)) {
            max_c = max(max_c, cs[a][j], cs[b][j]);
            a = ps[a][j];
            b = ps[b][j];
        }

        res[i] = c_sum - max_c + c;
    }

    writefln!"%(%d\n%)"(res);
}
