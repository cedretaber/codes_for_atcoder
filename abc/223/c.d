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
    double[] AA, BB; get_lines(N, AA, BB);

    auto s = AA.sum();

    double l = 0, r = s + 1, p;
    foreach (_; 0..100) {
        auto lr = (l + r) / 2;
        auto n = lr, m = lr;
        double x = 0, y = s;
        int i, j = N - 1;
        while (i < N && n > 0) {
            auto a = AA[i], b = BB[i]; ++i;
            if (n > a / b) {
                x += a;
                n -= a / b;
            } else {
                x += b * n;
                n = 0;
            }
        }
        while (j >= 0 && m > 0) {
            auto a = AA[j], b = BB[j]; --j;
            if (m > a / b) {
                y -= a;
                m -= a / b;
            } else {
                y -= b * m;
                m = 0;
            }
        }

        if (x >= y) {
            r = lr;
        } else {
            l = lr;
        }
        p = x;
    }

    writefln!"%.12f"(p);
}
