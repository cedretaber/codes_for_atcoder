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
    int N; get(N);
    long[][] aa; get_lines(N, aa);

    auto DP = new long[](1<<N);
    int[] bs;
    foreach (b; 0..(1<<N)) {
        long x;
        foreach (i; 0..N-1) foreach (j; i+1..N) if ((b & (1<<i)) && (b & (1<<j))) x += aa[i][j];
        DP[b] = x;
        bs ~= b;
    }
    
    sort!((a, b) => popcnt(a) < popcnt(b))(bs);
    foreach (x; bs) {
        auto cx = (1<<N) - 1 - x;
        for (auto y = cx; y; y = (y - 1) & cx) DP[x | y] = max(DP[x | y], DP[x] + DP[y]);
    }
    writeln(DP[(1<<N) - 1]);
}