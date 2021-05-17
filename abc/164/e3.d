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

void main()
{
    int N, M, S; get(N, M, S);
    alias P = Tuple!(int, "to", int, "c", long, "t");
    auto G = new P[][N];
    foreach (_; 0..M) {
        int U, V, A, B; get(U, V, A, B); --U; --V;
        G[U] ~= P(V, A, B);
        G[V] ~= P(U, A, B);
    }
    auto CS = new int[](N);
    auto DS = new long[](N);
    foreach (i; 0..N) {
        int C, D; get(C, D);
        CS[i] = C;
        DS[i] = D;
    }

    auto DP = new long[][](N, 3001);
    foreach (ref dp; DP) dp[] = long.max / 3;
    DP[0][min(S, 3000)] = 0;
    auto Q = heapify!"a.t > b.t"([P(0, min(S, 3000), 0)]);
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        if (DP[to][min(3000, c + CS[to])] > t + DS[to]) {
            DP[to][min(3000, c + CS[to])] = t + DS[to];
            Q.insert(P(to, c + CS[to], t + DS[to]));
        }
        foreach (n; G[to]) if (c >= n.c && DP[n.to][c - n.c] > t + n.t) {
            DP[n.to][c - n.c] = t + n.t;
            Q.insert(P(n.to, c - n.c, t + n.t));
        }
    }
    foreach (i; 1..N) writeln(DP[i].minElement());
}
