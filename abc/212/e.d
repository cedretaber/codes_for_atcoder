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

long P = 998244353L;

void main()
{
    int N, M, K; get(N, M, K);
    auto bs = new int[][N];
    foreach (i; 0..N) bs[i] ~= i;
    while (M--) {
        int U, V; get(U, V); --U; --V;
        bs[U] ~= V;
        bs[V] ~= U;
    }

    auto DP = new long[][](K + 1, N);
    DP[0][0] = 1;
    foreach (k; 0..K) {
        long s;
        foreach (i; 0..N) (s += DP[k][i]) %= P;
        foreach (i; 0..N) {
            long m;
            foreach (j; bs[i]) (m += DP[k][j]) %= P;
            DP[k + 1][i] = (s + P - m) % P;
        }
    }
    writeln(DP[K][0]);
}
