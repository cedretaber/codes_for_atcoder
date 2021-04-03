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
    long N; get(N);
    long[] AA; get(AA);
    long[] BB; get(BB);

    long solve(long n, ref long[][] dp, long[] aa, long[] bb) {
        foreach (i; 0..dp[0].length) dp[3][i] = i.to!long;
        foreach_reverse (i; 0..3) foreach (s; 0..dp[0].length) {
            dp[i][s] = dp[i + 1][s];
            if (s >= aa[i]) dp[i][s] = max(dp[i][s], dp[i][s - aa[i]] + bb[i]);
        }
        return dp[0][n];
    }

    auto DP1 = new long[][](4, 5001);
    auto DP2 = new long[][](4, 5000 * 5000 + 1);
    writeln(solve(solve(N, DP1, AA, BB), DP2, BB, AA));
}
