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
    int N, M, K; get(N, M, K);
    auto AS = new bool[](N);
    if (K) foreach (a; readln.split.to!(int[])) AS[a] = true;

    int c;
    foreach (i; 0..N) {
        if (AS[i]) {
            ++c;
            if (c >= M) return writeln(-1);
        } else {
            c = 0;
        }
    }

    auto DP = new double[](N + M + 1);
    DP[] = 0;
    auto FP = new double[](N + M + 1);
    FP[] = 0;

    foreach (i; N..N+M+1) {
        DP[N-1] += 1.0 / M.to!double;
        if (i - M - 1 >= 0) DP[i - M - 1] -= 1.0 / M.to!double;
    }
    foreach_reverse (i; 0..N) {
        DP[i] += DP[i+1];
        FP[i] += FP[i+1];
        double p, q;
        if (AS[i]) {
            p = 1.0 / M.to!double;
            q = 1.0 / M.to!double;
        } else {
            p = (DP[i] + 1) / M.to!double;
            q = FP[i] / M.to!double;
        }
        if (i) {
            DP[i-1] += p;
            FP[i-1] += q;
        }
        if (i - M - 1 >= 0) {
            DP[i - M - 1] -= p;
            FP[i - M - 1] -= q;
        }
    }

    writefln!"%.6f"(DP[0] / (1 - FP[0]));
}

/*

f(0) = f(0) * A + B
f(0)(1 - A) = B
f(0) = B / (1 - A)



0        1         2
         0x + 0.5  0
0x + 0.5 0x + 0.5
0.5x

*/