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

enum MAX_N = 20;

void main()
{
    int N; long T; get(N, T);
    long[] AS; get(AS);

    void run(int i, int e, long x, ref long[] arr) {
        if (i == e) {
            arr ~= x;
        } else {
            run(i+1, e, x, arr);
            run(i+1, e, x + AS[i], arr);
        }
    }

    long[] bs, cs;
    run(0, min(MAX_N, N), 0, bs);
    if (N <= MAX_N) {
        writeln(bs.filter!(a => a <= T).maxElement());
    } else {
        run(MAX_N, N, 0, cs);
        auto rbt = redBlackTree(bs);
        long res;
        foreach (c; cs) {
            auto t = T - c;
            if (t < 0) continue;
            auto ls = rbt.lowerBound(t + 1);
            res = max(res, c + ls.back);
        }
        writeln(res);
    }
}