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
    double xs, ys, xt, yt; get(xs, ys, xt, yt);
    int N; get(N);
    double[] xx, yy, rr; get_lines(N, xx, yy, rr);
    xx ~= [xs, xt];
    yy ~= [ys, yt];
    rr ~= [0.0, 0.0];

    auto G = new double[][](N + 2, N + 2);
    foreach (i; 0..N + 1) foreach (j; i + 1..N + 2) {
        auto d = sqrt((xx[i] - xx[j]) ^^ 2 + (yy[i] - yy[j]) ^^ 2);
        auto p = rr[i] + rr[j];
        G[i][j] = G[j][i] = max(0.0, d - p);
    }

    auto DP = new double[](N + 2);
    DP[] = double.infinity;
    DP[N] = 0.0;
    alias S = Tuple!(int, "i", double, "c");
    auto Q = heapify!"a.c > b.c"([S(N, 0.0)]);
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        if (DP[i] < c) continue;
        foreach (j; 0..N + 2) if (j != i && DP[j] > c + G[i][j]) {
            DP[j] = c + G[i][j];
            Q.insert(S(j, DP[j]));
        }
    }
    writefln!"%.12f"(DP[N + 1]);
}
