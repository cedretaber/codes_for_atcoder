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

alias S = Tuple!(int, "i", int, "s");

void main()
{
    int N; get(N);
    auto ss = 0.iota(N).map!(i => S(i, 0)).array;
    foreach (_; 0..N * (N - 1) / 2) {
        int A, B, C, D; get(A, B, C, D); --A; --B;
        if (C > D) {
            ss[A].s += 3;
        } else if (D > C) {
            ss[B].s += 3;
        } else {
            ss[A].s += 1;
            ss[B].s += 1;
        }
    }
    sort!"a.s > b.s"(ss);
    auto res = new int[](N);
    int r, d = 1, last;
    foreach (s; ss) {
        if (s.s == last) {
            d += 1;
        } else {
            r += d;
            d = 1;
        }
        res[s.i] = r;
        last = s.s;
    }
    writefln!"%(%d\n%)"(res);
}