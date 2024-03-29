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
    int K; get(K);
    double[] RS; get_lines(2^^K, RS);

    auto DP = new double[][](2^^K, K + 1);
    foreach (i; 0..2^^K) DP[i][0] = 1.0;

    foreach (k; 1..K + 1) foreach (i; 0..2^^K) {
        double r = 0;
        auto mask = ~((1 << k) - 1);
        foreach (j; 0..2^^K) if ((i & mask) == (j & mask) && !(i & (1 << (k - 1))) == !!(j & (1 << (k - 1)))) {
            r += DP[j][k - 1] / (1 + 10 ^^ ((RS[j] - RS[i]) / 400));
        }
        DP[i][k] = DP[i][k - 1] * r;
    }
    foreach (i; 0..2^^K) writefln!"%.12f"(DP[i][K]);
}
