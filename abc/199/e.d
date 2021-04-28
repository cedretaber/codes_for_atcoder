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

import core.bitop;

void main()
{
    int N, M; get(N, M);
    auto YY = new int[][N];
    auto ZZ = new int[][N];
    foreach (_; 0..M) {
        int X, Y, Z; get(X, Y, Z); --X;
        YY[X] ~= Y;
        ZZ[X] ~= Z;
    }

    auto DP = new long[][](N + 1, 2^^N);
    DP[0][0] = 1;
    foreach (i; 0..N) {
        foreach (j; 0..2^^N) if (DP[i][j]) {
            foreach (k; 0..N) if (!(j & (1<<k))) {
                auto n = j | (1<<k);
                foreach (x; 0..YY[i].length) {
                    auto y = YY[i][x];
                    auto z = ZZ[i][x];
                    if (popcnt(n & ((1<<y) - 1)) > z) goto ng;
                }
                DP[i + 1][n] += DP[i][j];
                ng:
            }
        }
    }
    writeln(DP[N][2^^N - 1]);
}
