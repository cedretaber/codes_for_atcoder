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
    int N, M, Q; get(N, M, Q);
    int[] ts, xs; long[] ys; get_lines(Q, ts, xs, ys);
    auto nn = (ys ~ 0).sort().uniq().array();
    int[long] y2i;
    foreach (i, n; nn) y2i[n] = i.to!int;
    auto len = nn.length.to!int;

    alias F = FenwickTree!long;
    auto aa = F(len);
    auto bb = F(len);
    auto ia = F(len);
    auto ib = F(len);
    ia.add(0, N);
    ib.add(0, M);

    auto pai = new int[](N);
    auto pbi = new int[](M);
    auto pay = new long[](N);
    auto pby = new long[](M);

    long res;
    foreach (q; 0..Q) {
        auto x = xs[q] - 1;
        auto y = ys[q];
        auto i = y2i[y];
        void solve(ref int[] pp, ref long[] pys, ref F cc, ref F dd, ref F ii, ref F jj) {
            auto pi = pp[x];
            auto py = pys[x];
            cc.add(pi, -py);
            ii.add(pi, -1);
            res += dd.sum(0, pi) - py * jj.sum(0, pi);

            pp[x] = i;
            pys[x] = y;
            cc.add(i, y);
            ii.add(i, 1);
            res += y * jj.sum(0, i) - dd.sum(0, i);
        }
        if (ts[q] == 1) {
            solve(pai, pay, aa, bb, ia, ib);
        } else {
            solve(pbi, pby, bb, aa, ib, ia);
        }
        writeln(res);
    }
}
