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

enum P = 998244353L;

void main()
{
    int N; get(N);
    int[] WS; get(WS);
    auto s = WS.sum;
    if (s % 2 == 1) return writeln(0);

    long[] F = [1L];
    foreach (i; 0..N) F ~= F[i] * (i + 1) % P;

    auto DP = new long[][][](2, s / 2 + 1, N);
    DP[1][0][0] = 1;
    foreach (i; 0..N) {
        foreach (j; 0..s / 2 + 1) foreach (k; 0..N) DP[0][j][k] = DP[1][j][k];
        foreach (j; 0..s / 2 + 1) foreach (k; 0..N) if (j + WS[i] <= s / 2 && k + 1 < N) {
            (DP[1][j + WS[i]][k + 1] += DP[0][j][k]) %= P;
        }
    }
    long res;
    foreach (k; 1..N) (res += F[k] * F[N - k] % P * DP[1][s / 2][k] % P) %= P;
    writeln(res);
}
