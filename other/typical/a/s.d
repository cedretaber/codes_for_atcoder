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

alias P = Tuple!(long, "x", long, "y");

long dist(P p, P q)
{
    return (p.x - q.x) ^^ 2 + (p.y - q.y) ^^ 2;
}

import core.bitop;

void main()
{
    int N, K; get(N, K);
    P[] ps; get_lines(N, ps);

    auto ds = new long[](1 << N);
    foreach (b; 0 .. (1 << N)) {
        long d;
        foreach (i; 0..N - 1) foreach (j; i + 1..N) if ((b & (1 << i)) && (b & (1 << j))) {
            d = max(d, dist(ps[i], ps[j]));
        }
        ds[b] = d;
    }

    auto DP = new long[][](1 << N, K);
    foreach (ref dp; DP) dp[] = -1;
    long solve(int b, int k) {
        if (DP[b][k] == -1) {
            auto min_d = ds[b];
            if (k > 0) {
                auto c = (b - 1) & b;
                while (c) {
                    min_d = min(min_d, max(ds[c], solve(b & ~c, k - 1)));
                    c = (c - 1) & b;
                }
            }
            DP[b][k] = min_d;
        }
        return DP[b][k];
    }
    writeln(solve((1 << N) - 1, K - 1));
}
