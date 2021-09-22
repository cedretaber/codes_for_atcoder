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
    int T; get(T); while (T--) {
        long n2, n3, n4; get(n2, n3, n4);
        long r;

        auto n6 = n3 / 2;
        auto r1 = min(n6, n4);
        r += r1;
        n6 -= r1;
        n4 -= r1;
        if (n6 > 0) {
            r1 = min(n6, n2 / 2);
            r += r1;
            n2 -= r1 * 2;
        }
        auto n8 = n4 / 2;
        long n1;
        if (n4 % 2 == 1) n1 = 4;
        auto r2 = min(n8, n2);
        n2 -= r2;
        r += r2;
        n1 += n2 * 2;
        r += n1 / 10;
        writeln(r);
    }
}
