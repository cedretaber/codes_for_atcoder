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
    int N; long X; get(N, X);
    long[] AA; get(AA);

    auto r = X - AA.maxElement();
    foreach (n; 2..N+1) {
        auto DP = new long[][][](2, N + 1, n);
        foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = long.min / 3;
        DP[0][0][0] = 0;
        foreach (i; 0..N) {
            foreach (j; 0..N + 1) foreach (k; 0..n) DP[(i + 1) % 2][j][k] = DP[i % 2][j][k];
            foreach (j; 0..N) foreach (k; 0..n) {
                DP[(i + 1) % 2][j + 1][(k + AA[i]) % n] = max(DP[(i + 1) % 2][j + 1][(k + AA[i]) % n], DP[i % 2][j][k] + AA[i]);
            }
        }
        auto x = X % n;
        if (DP[N % 2][n][x] > 0) r = min(r, (X - DP[N % 2][n][x]) / n);
    }
    writeln(r);
}