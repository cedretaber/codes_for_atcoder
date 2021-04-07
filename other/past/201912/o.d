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
    int[][] DS; get_lines(N, DS);
    int[int] nm;
    foreach (i, n; DS.joiner().array().sort().array()) nm[n] = i.to!int;
    auto n2d = new int[](N * 6);
    foreach (i, ref dd; DS) foreach (ref f; dd) {
        f = nm[f];
        n2d[f] = i.to!int;
    }

    auto DP = new double[](N * 6 + 1);
    DP[N * 6] = 1;
    auto dp = new double[](N);
    dp[] = 1;
    double max_p = 0;
    foreach_reverse (i; 0..N * 6) {
        auto d = n2d[i];
        dp[d] += DP[i + 1] / 6;
        DP[i] = max_p = max(max_p, dp[d]);
    }
    writefln!"%.12f"(DP[0]);
}
