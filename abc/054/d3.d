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
    int N, Ma, Mb; get(N, Ma, Mb);
    auto len = 10 * N;
    auto DP = new int[][](len + 1, len + 1);
    foreach (ref dp; DP) dp[] = int.max / 3;
    DP[0][0] = 0;
    while (N--) {
        int a, b, c; get(a, b, c);
        foreach_reverse (i; 0..len) foreach_reverse (j; 0..len) if (i + a <= len && j + b <= len) {
            DP[i + a][j + b] = min(DP[i + a][j + b], DP[i][j] + c);
        }
    }
    auto res = int.max / 3;
    auto a = Ma, b = Mb;
    while (a <= len && b <= len) {
        res = min(res, DP[a][b]);
        a += Ma;
        b += Mb;
    }
    writeln(res == int.max / 3 ? -1 : res);
}
