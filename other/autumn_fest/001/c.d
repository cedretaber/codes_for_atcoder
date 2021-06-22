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
    int N; get(N);
    int[] XX; get(XX);

    auto bs = new int[][N + 1];
    foreach (b; 0..2^^N) bs[popcnt(b)] ~= b;

    auto DP = new double[][](3, 2^^N);
    DP[0][0] = 1;
    double r = 0;
    foreach (t; 1..N) {
        DP[1][] = 0;
        DP[2][] = 0;
        foreach (b; bs[t - 1]) foreach (j; 0..N) if (!(b & (1 << j))) {
            DP[1][b | (1 << j)] += DP[0][b] / (N - t + 1);
        }
        foreach (b; bs[t]) foreach (j; 0..N) if (!(b & (1 << j))) {
            DP[2][b | (1 << j)] += DP[1][b] / (N - t);
        }
        DP[0][] = 0;
        foreach (b; bs[t + 1]) foreach (j; 0..N) if (b & (1 << j)) {
            r += XX[j] * DP[2][b] / (t + 1);
            DP[0][b & ~(1 << j)] += DP[2][b] / (t + 1);
        }
    }
    writefln!"%.12f"(r);
}
