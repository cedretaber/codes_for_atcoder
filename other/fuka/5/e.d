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
    for (;;) {
        int N; get(N);
        if (N == 0) return;

        int[] XS; get(XS);

        double[] DP = new double[](N);
        double[] IS = new double[](N);
        foreach_reverse (i; 0..N) {
            if (i == N-1) {
                DP[i] = 0;
                IS[i] = 0;
            } else if (XS[i] == -1) {
                DP[i] = 0;
                IS[i] = 1;
            } else if (XS[i] == 0) {
                DP[i] = 1;
                IS[i] = 0;
                static foreach (d; 1..7) if (i + d < N) {
                    DP[i] += DP[i + d] / 6.0;
                    IS[i] += IS[i + d] / 6.0;
                }
            } else {
                if (i + XS[i] >= N-1) {
                    DP[i] = 0;
                    IS[i] = 0;
                } else {
                    DP[i] = DP[i + XS[i]];
                    IS[i] = IS[i + XS[i]];
                }
            }
        }

        writefln!"%.12f"(DP[0] / (1 - IS[0]));
    }
}

/*

f(x) = P + p * f(x)
(1 - p)f(x) = P
f(x) = P / (1 - p)

*/
