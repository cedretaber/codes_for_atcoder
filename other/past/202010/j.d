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

alias P = Tuple!(int, "to", long, "c");

void main()
{
    int N, M; get(N, M);
    long Xab, Xac, Xbc; get(Xab, Xac, Xbc);

    auto G = new P[][N+6];
    G[N] ~= P(N+4, Xab);
    G[N] ~= P(N+5, Xac);
    G[N+1] ~= P(N+3, Xab);
    G[N+1] ~= P(N+5, Xbc);
    G[N+2] ~= P(N+3, Xac);
    G[N+2] ~= P(N+4, Xbc);

    foreach (ii, c; readln.chomp.to!(char[])) {
        auto i = ii.to!int;
        if (c == 'A') {
            G[i] ~= P(N, 0);
            G[N+3] ~= P(i, 0);
        } else if (c == 'B') {
            G[i] ~= P(N+1, 0);
            G[N+4] ~= P(i, 0);
        } else {
            G[i] ~= P(N+2, 0);
            G[N+5] ~= P(i, 0);
        }
    }

    while (M--) {
        int A, B; long C; get(A, B, C); --A; --B;
        G[A] ~= P(B, C);
        G[B] ~= P(A, C);
    }

    auto DP = new long[](N + 6);
    DP[] = long.max / 3;
    DP[0] = 0;
    auto Q = heapify!"a.c > b.c"([P(0, 0)]);
    while (!Q.empty) {
        auto i = Q.front.to;
        auto c = Q.front.c;
        Q.popFront();
        if (DP[i] < c) continue;
        foreach (n; G[i]) if (DP[n.to] > c + n.c) {
            DP[n.to] = c + n.c;
            Q.insert(P(n.to, c + n.c));
        }
    }
    writeln(DP[N-1]);
}