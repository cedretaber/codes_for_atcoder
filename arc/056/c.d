import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

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
    int N, K; get(N, K);
    int[][] ww; get_lines(N, ww);

    auto DP = new int[](2^^N);
    int[] xx;
    foreach (x; 0..2^^N) {
        xx ~= x;
        DP[x] = K;
        foreach (i; 0..N-1) if (x & (1<<i)) foreach (j; i+1..N) if (x & (1<<j)) DP[x] += ww[i][j];
    }
    sort!((a, b) => popcnt(a) < popcnt(b))(xx);
    foreach (x; xx) {
        auto y = (x - 1) & x;
        while (y) {
            auto z = x & ~y;
            DP[x] = max(DP[x], DP[y] + DP[z]);
            y = (y - 1) & x;
        }
    }

    int base;
    foreach (i; 0..N-1) foreach (j; i+1..N) base += ww[i][j];
    writeln(DP[2^^N - 1] - base);
}

/*

0 4 3 3
4 0 1 1
3 1 0 3
3 1 3 0

3n
1 + 2 => 4

2n
1 + 2 + 3 => 4 + 3 + 1 = 8
1 + 3 + 4 => 3 + 3 + 3 = 9

n


*/