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
    int[] AA; get(AA);

    auto ps = new int[][10 ^^ 5 + 1];
    foreach (a; 2..10 ^^ 5 + 1) {
        auto x = a;
        for (auto d = 2; x != 1; ++d) if (x % d == 0) {
            ps[a] ~= d;
            while (x % d == 0) x /= d;
        }
    }

    bool[int] pm;
    foreach (a; AA) foreach (p; ps[a]) pm[p] = true;

    int[] res = [1];
    foreach (i; 2..M + 1) {
        foreach (p; ps[i]) if (p in pm) goto ng;
        res ~= i;
        ng:
    }
    writefln!"%d\n%(%d\n%)"(res.length, res);
}
