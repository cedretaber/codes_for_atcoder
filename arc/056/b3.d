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
    int N, M, S; get(N, M, S); --S;
    auto G = new int[][N];
    while (M--) {
        int u, v; get(u, v); --u; --v;
        G[u] ~= v;
        G[v] ~= u;
    }

    auto rs = new int[](N);
    rs[] = -1;
    rs[S] = S;
    alias X = Tuple!(int, "i", int, "d");
    auto ss = heapify!"a.d < b.d"([X(S, S)]);
    while (!ss.empty) {
        auto i = ss.front.i;
        auto d = ss.front.d;
        ss.popFront();
        foreach (j; G[i]) {
            auto dd = min(d, j);
            if (rs[j] < dd) {
                rs[j] = dd;
                ss.insert(X(j, dd));
            }
        }
    }
    foreach (i, r; rs) if (r == i) writeln(i + 1);
}