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
    auto G = new int[][N + M];
    foreach (i; 0..M) {
        int K; get(K);
        int[] RR; get(RR);
        foreach (r; RR) {
            G[r - 1] ~= N + i;
            G[N + i] ~= r - 1;
        }
    }

    auto DP = new int[](N + M);
    DP[] = int.max / 3;
    DP[0] = 0;

    alias S = Tuple!(int, "i", int, "t");
    auto ss = [S(0, 0)];
    while (!ss.empty) with(ss.front) {
        ss.popFront();
        foreach (j; G[i]) {
            auto tt = t + (j < N ? 1 : 0);
            if (DP[j] > tt) {
                DP[j] = tt;
                ss ~= S(j, tt);
            }
        }
    }
    foreach (i; 0..N) writeln(DP[i] == int.max / 3 ? -1 : DP[i]);
}
