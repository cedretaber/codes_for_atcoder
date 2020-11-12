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
    int N, M; get(N, M);
    int[] xs, ys; get_lines(M, xs, ys);
    foreach (i; 0..M) {
        --xs[i];
        --ys[i];
    }

    int r;
    foreach (s; 1..(1<<N)-1) {
        auto g = new int[][N];
        foreach (i; 0..M) {
            auto x = xs[i];
            auto y = ys[i];
            if (!!(s & (1<<x)) != !!(s & (1<<y))) {
                g[x] ~= y;
                g[y] ~= x;
            }
        }
        auto m = new bool[](N);
        void walk(int i) {
            m[i] = true;
            foreach (j; g[i]) if (!m[j]) walk(j);
        }
        walk(0);
        if (m.all!"a") ++r;
    }
    writeln(r/2);
}