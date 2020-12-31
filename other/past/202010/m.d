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

alias P = Tuple!(int, "to", int, "i");
alias C = Tuple!(int, "c", int, "d");
alias E = Tuple!(int, "i", int, "d");

void main()
{
    int N, Q; get(N, Q);
    auto T = new P[][N];
    foreach (i; 0..N-1) {
        int a, b; get(a, b); --a; --b;
        T[a] ~= P(b, i);
        T[b] ~= P(a, i);
    }

    auto ps = new P[](N);
    auto ds = new int[](N);
    auto es = new E[](N);
    void walk(int i, int p, int d) {
        ds[i] = d;
        es[i] = E(i, d);
        foreach (n; T[i]) if (n.to != p) {
            ps[n.to] = P(i, n.i);
            walk(n.to, i, d + 1);
        }
    }
    walk(0, -1, 0);
    sort!"a.d > b.d"(es);

    alias RBT = typeof(redBlackTree!"a.d > b.d"(C(0, -1)));
    auto bs = new RBT[](N);
    foreach (ref b; bs) b = redBlackTree!"a.d > b.d"(C(0, -1));
    foreach (i; 0..Q) {
        int u, v, c; get(u, v, c); --u; --v;
        bs[u].insert(C(c, i));
        bs[v].insert(C(c, i));
    }

    auto rs = new int[](N - 1);
    foreach (e; es[0..$-1]) {
        auto p = ps[e.i];
        rs[p.i] = bs[e.i].front.c;

        auto x = bs[e.i];
        auto y = bs[p.to];
        if (x.length > y.length) swap(x, y);
        foreach (b; x) if (b.d >= 0) {
            if (y.equalRange(b).empty) {
                y.insert(b);
            } else {
                y.removeKey(b);
            }
        }
        bs[p.to] = y;
    }
    writefln!"%(%d\n%)"(rs);
}