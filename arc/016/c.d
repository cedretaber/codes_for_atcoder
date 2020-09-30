import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!T)) {
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
    int N, M; get(N, M);
    double[] CS;
    auto PS = new double[][](M, N);
    foreach (m; 0..M) {
        int c, cost; get(c, cost);
        CS ~= cost.to!double;
        foreach (_; 0..c) {
            int i, p; get(i, p);
            PS[m][i-1] = p.to!double / 100;
        }
    }

    auto min_cost = new double[](N);
    min_cost[] = double.infinity;
    foreach (i; 0..N) foreach (j; 0..M) if (!isNaN(PS[j][i])) {
        min_cost[i] = min(min_cost[i], CS[j] / PS[j][i]);
    }

    auto PAT = 0.iota(1<<N).array.to!(uint[]);
    sort!((a, b) => popcnt(a) > popcnt(b))(PAT);
    auto DP = new double[](1<<N);
    DP[$-1] = 0;
    foreach (b; PAT[1..N+1]) {
        foreach (i; 0..N) if ((~b) & (1<<i)) {
            DP[b] = min_cost[i];
            break;
        }
    }
    foreach (b; PAT[N+1..$]) {
        double X = int.max;
        foreach (j; 0..M) {
            double s = CS[j], d = 1;
            foreach (i; 0..N) {
                auto p = PS[j][i];
                if (!isNaN(p)) {
                    auto n = b | (1<<i);
                    if (n == b) {
                        d -= p;
                    } else {
                        s += DP[n] * p;
                    }
                }
            }
            if (s > CS[j]) X = min(X, s / d);
        }
        DP[b] = X;
    }
    writefln!"%.12f"(DP[0]);
}

/*

M = m + x * 0.2 + y * 0.4 + M * 0.6]
(1 - 0.6) * M = m + x*0.2 + y*0.3
M = (m + x*0.2 + y*0.3) / (1 - 0.6)

*/