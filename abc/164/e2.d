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

alias P = Tuple!(int, "to", int, "c", long, "t");

void main()
{
    int N, M, S; get(N, M, S);
    auto G = new P[][N];
    foreach (_; 0..M) {
        int U, V, A; long B; get(U, V, A, B);
        G[U-1] ~= P(V-1, A, B);
        G[V-1] ~= P(U-1, A, B);
    }
    int[] cs; long[] ds; get_lines(N, cs, ds);

    auto c_max = N*50;
    auto DP = new long[][](N, c_max+1);
    foreach (ref dp; DP) dp[] = long.max/3;
    auto Q = heapify!"a.t > b.t"([P(0, min(c_max, S), 0)]);
    while (!Q.empty) {
        auto i = Q.front.to;
        auto c = Q.front.c;
        auto t = Q.front.t;
        Q.popFront();
        if (c < c_max) {
            auto cc = min(c_max, c + cs[i]);
            if (DP[i][cc] > t + ds[i]) {
                DP[i][cc] = t + ds[i];
                Q.insert(P(i, cc, t + ds[i]));
            }
        }
        foreach (to; G[i]) if (c >= to.c && DP[to.to][c - to.c] > t + to.t) {
            DP[to.to][c - to.c] = t + to.t;
            Q.insert(P(to.to, c - to.c, t + to.t));
        }
    }
    foreach (i; 1..N) {
        writeln(DP[i].minElement);
    }
}