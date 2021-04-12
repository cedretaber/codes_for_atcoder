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
    double[] XX, YY, TT, RR; get_lines(N, XX, YY, TT, RR);

    auto G = new double[][](N, N);
    foreach (i; 0..N - 1) {
        foreach (j; i + 1..N) {
            auto d = sqrt((XX[i] - XX[j])^^2 + (YY[i] - YY[j])^^2);
            G[i][j] = d / min(TT[i], RR[j]);
            G[j][i] = d / min(RR[i], TT[j]);
        }
    }

    auto DP = new double[](N);
    DP[0] = 0;
    alias S = Tuple!(int, "i", double, "t");
    auto Q = heapify!"a.t > b.t"([S(0, 0)]);
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        foreach (j; 0..N) if (i != j && (isNaN(DP[j]) || DP[j] > t + G[i][j])) {
            DP[j] = t + G[i][j];
            Q.insert(S(j, DP[j]));
        }
    }
    sort!"a > b"(DP[1..$]);
    double r = 0;
    foreach (i, t; DP[1..$]) r = max(r, i + t);
    writefln!"%.12f"(r);
}
