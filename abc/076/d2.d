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
    int[] TS; get(TS);
    int[] VS; get(VS);

    auto l = TS.sum() * 2;
    auto hs = new int[](l);
    foreach (i; 0..l) hs[i] = i;
    foreach_reverse (i; 0..l) hs[i] = min(hs[i], l - i);

    int p;
    foreach (i; 0..N) {
        auto t = TS[i] * 2;
        auto v = VS[i] * 2;
        foreach_reverse (j; 0..p) hs[j] = min(hs[j], v + p - j);
        foreach (j; p..p + t) hs[j] = min(hs[j], v);
        foreach (j; p + t..l) hs[j] = min(hs[j], v + j - p - t);
        p += t;
    }
    double s = 0;
    foreach (i; 0..l) s += hs[i];
    writefln!"%.12f"(s / 4);
}
