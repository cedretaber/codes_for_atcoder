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

long ceil_to(long n, long m)
{
    if (n >= 0) return (n + m - 1) / m * m;
    return -(-n / m) * m;
}

alias P = Tuple!(int, "to", int, "k", long, "t");

void main()
{
    int N, M, X, Y; get(N, M, X, Y); --X; --Y;
    auto G = new P[][N];
    while (M--) {
        int A, B, T, K; get(A, B, T, K); --A; --B;
        G[A] ~= P(B, K, T);
        G[B] ~= P(A, K, T);
    }

    alias S = Tuple!(int, "i", long, "t");
    auto Q = heapify!"a.t > b.t"([S(X, 0)]);
    auto DP = new long[](N);
    DP[] = long.max / 3;
    DP[X] = 0;
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        if (DP[i] < t) continue;
        foreach (p; G[i]) {
            auto u = ceil_to(t, p.k) + p.t;
            if (DP[p.to] > u) {
                DP[p.to] = u;
                Q.insert(S(p.to, u));
            }
        }
    }
    writeln(DP[Y] == long.max / 3 ? -1 : DP[Y]);
}