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
    if (N == 1) {
        writeln(0);
        return;
    }
    double[] xs, ys, ts, rs; get_lines(N, xs, ys, ts, rs);
    auto G = new double[][](N, N);
    foreach (i; 0..N) foreach (j; i+1..N) {
        auto d = sqrt((xs[i] - xs[j])^^2 + (ys[i] - ys[j])^^2);
        G[i][j] = d / min(ts[i], rs[j]);
        G[j][i] = d / min(ts[j], rs[i]);
    }
    auto DP = new double[](N);
    DP[] = double.infinity;
    DP[0] = 0;
    alias S = Tuple!(int, "i", double, "c");
    auto Q = heapify!"a.c < b.c"([S(0, 0)]);
    while (!Q.empty) {
        auto i = Q.front.i;
        auto c = Q.front.c;
        Q.popFront();
        foreach (j; 0..N) if (DP[j] > c + G[i][j]) {
            DP[j] = c + G[i][j];
            Q.insert(S(j, DP[j]));
        }
    }
    sort!"a > b"(DP);
    DP = DP[0..$-1];
    foreach (i, ref e; DP) e += i;
    writefln!"%.12f"(DP.maxElement);
}