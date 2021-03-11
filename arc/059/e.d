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

enum P = 10L^^9 + 7;

void main()
{
    int N, C; get(N, C);
    long[] AA, BB; get(AA); get(BB);

    auto DP = new long[][](N + 1, C + 1);
    auto CS = new long[](C + 1);
    auto DS = new long[](C + 1);
    DP[0][C] = 1;
    foreach (i; 0..N) {
        foreach (x; AA[i]..BB[i] + 1) {
            CS[] = 0;
            DS[] = 0;
            foreach_reverse (r; 0..C + 1) {
                (CS[r] += DP[i][r] + DS[r]) %= P;
                if (r > 0) (DS[r - 1] += (DP[i][r] + DS[r]) % P * x % P) %= P;
            }
            foreach (r; 0..C + 1) (DP[i + 1][r] += CS[r]) %= P;
        }
    }
    writeln(DP[N][0]);
}
