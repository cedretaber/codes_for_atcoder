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
    int X, Y; get(X, Y);
    int N; get(N);
    int[] ts; long[] hs; get_lines(N, ts, hs);

    auto DP = new long[][][](2, X + 1, X + Y + 1);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2[] = long.min / 3;
    foreach (j; 0..X + 1) DP[0][j][X + Y - j] = 0;
    foreach (i; 0..N) foreach (j; 0..X + 1) foreach (k; 0..X + Y + 1) {
        DP[(i + 1) % 2][j][k] = max(DP[(i + 1) % 2][j][k], DP[i % 2][j][k]);
        if (j > 0 && k >= ts[i] - 1) {
            DP[(i + 1) % 2][j - 1][k - ts[i] + 1] =
                max(DP[(i + 1) % 2][j - 1][k - ts[i] + 1], DP[i % 2][j][k] + hs[i]);
        }
    }
    long r;
    foreach (j; 0..X + 1) foreach (k; 0..X + Y + 1) r = max(r, DP[N % 2][j][k]);
    writeln(r);
}
