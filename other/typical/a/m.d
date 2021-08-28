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
    alias P = Tuple!(int, "i", int, "u", int, "v");
    P[] ps;
    alias B = Tuple!(int, "i", int, "j");
    auto T = new B[][N];
    foreach (i; 0..N - 1) {
        int U, V; get(U, V); --U; --V;
        ps ~= P(i, U, V);
        T[U] ~= B(i, V);
        T[V] ~= B(i, U);
    }

    long[int][] DP; DP.length = N;
    long walk(int i, int p) {
        long s = N - 1;
        foreach (n; T[i]) if (n.i != p) {
            auto r = walk(n.j, n.i);
            DP[i][n.i] = r;
            s -= r;
        }
        if (p != -1) DP[i][p] = s;
        return N - s;
    }
    walk(0, -1);

    long r;
    foreach (p; ps) r += (N.to!long - DP[p.u][p.i]) * (N.to!long - DP[p.v][p.i]);
    writeln(r);
}
