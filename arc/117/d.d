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

void main()
{
    int N; get(N);
    auto T = new int[][N];
    foreach (_; 1..N) {
        int A, B; get(A, B); --A; --B;
        T[A] ~= B;
        T[B] ~= A;
    }

    int max_d, s;
    void walk(int i, int p, int d) {
        if (d > max_d) {
            max_d = d;
            s = i;
        }
        foreach (j; T[i]) if (j != p) walk(j, i, d + 1);
    }
    walk(0, -1, 0);

    alias B = Tuple!(int, "to", int, "l", int, "s");
    alias L = Tuple!(int, "l", int, "s");
    auto t = new B[][N];
    L make(int i, int p) {
        int x;
        foreach (j; T[i]) if (j != p) {
            auto l = make(j, i);
            t[i] ~= B(j, l.l, l.s);
            x += l.l + 1;
        }

        if (t[i].empty) return L(1, 1);
        sort!"a.l - a.s < b.l - b.s"(t[i]);
        return L(x + 1, x - t[i][$ - 1].l + t[i][$ - 1].s);
    }
    make(s, -1);
    auto res = new int[](N);
    int run(int i, int d) {
        res[i] = d;
        foreach (b; t[i]) d = run(b.to, d + 1);
        return d + 1;
    }
    run(s, 1);
    writefln!"%(%d %)"(res);
}
