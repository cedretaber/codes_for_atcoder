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
    int W, N; get(W, N);
    auto DP = new long[](W + 1);
    DP[] = -1; DP[0] = 0;
    auto memo = new long[](W + 1);
    while (N--) {
        int L, R; long V; get(L, R, V);
        memo[] = -1;
        foreach (i; 0..W + 1) if (DP[i] != -1 && i + L <= W) memo[i + L] = DP[i] + V;
        alias X = Tuple!(int, "i", long, "v");
        auto q = heapify!"a.v < b.v"([X(int.max, -1)]);
        foreach (i; 0..W + 1) {
            if (memo[i] >= 0) q.insert(X(i + R - L, memo[i]));
            while (i > q.front.i) q.popFront();
            if (q.front.i != int.max) DP[i] = max(DP[i], q.front.v);
        }
    }
    writeln(DP[W]);
}
