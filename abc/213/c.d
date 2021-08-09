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
    int H, W, N; get(H, W, N);
    alias C = Tuple!(int, "i", int, "a", int, "b");
    C[] cs;
    foreach (i; 0..N) {
        int A, B; get(A, B);
        cs ~= C(i, A, B);
    }
    int last, d;
    sort!"a.a < b.a"(cs);
    foreach (ref c; cs) {
        d += max(0, c.a - last - 1);
        last = c.a;
        c.a -= d;
    }
    last = 0; d = 0;
    sort!"a.b < b.b"(cs);
    foreach (ref c; cs) {
        d += max(0, c.b - last - 1);
        last = c.b;
        c.b -= d;
    }
    sort!"a.i < b.i"(cs);
    foreach (c; cs) writefln!"%d %d"(c.a, c.b);
}
